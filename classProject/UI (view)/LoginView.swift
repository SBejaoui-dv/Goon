//
//  LoginView.swift
//  GoogleSignInFirebaseSwiftUI
//

//
import SwiftUI
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift
import FirebaseCore

struct LoginView: View {
    @State private var loginError = ""
    @StateObject private var vm = AuthenticationView()

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Text("Welcome")
                    .font(.largeTitle.bold())

                GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .light)) {
                    Task {
                        do {
                            try await vm.signInWithGoogle()
                            // No manual navigation needed:
                            // classProjectApp listens to Auth and will show MainView
                        } catch {
                            loginError = error.localizedDescription
                        }
                    }
                }
                .padding(.horizontal)

                if !loginError.isEmpty {
                    Text(loginError)
                        .foregroundColor(.red)
                        .font(.caption)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }

                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    LoginView()
}

