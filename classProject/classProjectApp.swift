import SwiftUI
import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import Firebase
import FamilyControls

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
        return true
    }

    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }
}

@main
struct classProjectApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    @State private var userLoggedIn: Bool

    init() {
       
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
        _userLoggedIn = State(initialValue: Auth.auth().currentUser != nil)
    }

    var body: some Scene {
        WindowGroup {
            Group {
                if userLoggedIn {
                    MainView()
                        .task {
                            await requestFamilyControlsAuthorization()
                        }
                } else {
                    LoginView()
                }
            }
            .onAppear {
                Auth.auth().addStateDidChangeListener { _, user in
                    userLoggedIn = (user != nil)
                }
            
            }
        }
    }
}

@MainActor
func requestFamilyControlsAuthorization() async {
    do {
        try await AuthorizationCenter.shared.requestAuthorization(for: .individual)
        print("FamilyControls authorized")
    } catch {
        print("FamilyControls authorization failed:", error)
    }
}

#Preview {
    MainView()
}

