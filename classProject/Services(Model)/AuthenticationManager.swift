import SwiftUI
import CoreLocation
import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import FirebaseFirestore

class AuthenticationView: ObservableObject {
    @Published var isLoginSuccessed = false

    func signInWithGoogle() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        GIDSignIn.sharedInstance.signIn(withPresenting: Application_utility.rootViewController) { result, error in

            if let error = error {
                print("Google sign-in error:", error.localizedDescription)
                return
            }

            guard
                let user = result?.user,
                let idToken = user.idToken
            else { return }

            let accessToken = user.accessToken

            let credential = GoogleAuthProvider.credential(
                withIDToken: idToken.tokenString,
                accessToken: accessToken.tokenString
            )

            Auth.auth().signIn(with: credential) { res, error in
                if let error = error {
                    print("Firebase sign-in error:", error.localizedDescription)
                    return
                }

                guard let firebaseUser = res?.user else { return }
                print("Signed in Firebase user:", firebaseUser.uid)

                self.isLoginSuccessed = true

                // Save basic profile
                self.saveUserProfileToFirestore(user: firebaseUser)

                // Now request location and merge it into the same doc
                LocationManager.shared.requestLocation { loc, placeName in
                    self.updateUserLocationInFirestore(
                        uid: firebaseUser.uid,
                        location: loc,
                        placeName: placeName
                    )
                }
            }
        }
    }

    private func saveUserProfileToFirestore(user: FirebaseAuth.User) {
        let db = Firestore.firestore()
        let uid = user.uid

        let data: [String: Any] = [
            "email": user.email ?? "",
            "displayName": user.displayName ?? user.email ?? "",
            "photoURL": user.photoURL?.absoluteString as Any,
            "updatedAt": FieldValue.serverTimestamp()
        ]

        print("Writing user doc with data:", data)

        db.collection("users").document(uid).setData(data, merge: true) { error in
            if let error = error {
                print("Failed to save user profile:", error)
            } else {
                print("User profile saved/updated (location will merge if available)")
            }
        }
    }

    private func updateUserLocationInFirestore(
        uid: String,
        location: CLLocation?,
        placeName: String?
    ) {
        guard let location = location else {
            print("No location to save (user denied permission).")
            return
        }

        var data: [String: Any] = [
            "location": [
                "lat": location.coordinate.latitude,
                "lng": location.coordinate.longitude
            ]
        ]

        if let placeName = placeName {
            data["locationName"] = placeName
        }

        let db = Firestore.firestore()
        print("Merging location data:", data)

        db.collection("users").document(uid).setData(data, merge: true) { error in
            if let error = error {
                print("Failed to save location:", error)
            } else {
                print("Location merged into user doc")
            }
        }
    }

    func logout() async throws {
        GIDSignIn.sharedInstance.signOut()
        try Auth.auth().signOut()
        isLoginSuccessed = false
    }
}
