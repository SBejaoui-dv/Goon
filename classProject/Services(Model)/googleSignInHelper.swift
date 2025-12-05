//
//  googleSignInHelper.swift
//  classProject
//
//  Created by Sebastian Bejaoui on
//



import Foundation
import GoogleSignIn
import GoogleSignInSwift
import FirebaseCore
import FirebaseAuth



//struct GoogleResultToken {
//    let accessToken: String
//    let idToken: String
//    
//}
//final class GoogleSignInHelper {
//    
//    @MainActor
//    func signIn() async throws -> GoogleResultToken {
//        guard let topViewController = Utils.shared.getTopViewController() else  {
//            throw URLError(.cannotFindHost)
//            
//        }
//        let result = try await GIDSignIn.sharedInstance.signIn(withPresenting: topViewController)
//        guard let idToken = result.user.idToken?.tokenString else {
//            throw URLError(.badServerResponse)
//        }
//        let accessToken = result.user.accessToken.tokenString
//        return GoogleResultToken(accessToken: accessToken, idToken: idToken)
//    }
//}



