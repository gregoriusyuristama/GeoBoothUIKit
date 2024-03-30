//
//  AuthenticationInteractor.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 3/13/24.
//

import Auth
import Foundation
import KeychainSwift

class AuthenticationInteractor: AuthenticationInteractorProtocol {
    var presenter: (any AuthenticationPresenterProtocol)?
    
    func doAuth(email: String, password: String, completion: @escaping (User?, Error?) -> Void) {
        Task {
            do {
                let result = try await SupabaseSingleton
                    .shared.client
                    .auth.signIn(
                        email: email,
                        password: password
                    )
                let keychain = KeychainSwift()
                keychain.set(result.accessToken, forKey: KeychainKeyConstant.accessToken, withAccess: .accessibleWhenUnlocked)
                keychain.set(password, forKey: KeychainKeyConstant.password, withAccess: .accessibleWhenUnlocked)
                keychain.set(email, forKey: KeychainKeyConstant.email, withAccess: .accessibleWhenUnlocked)
                keychain.set(result.user.id.uuidString, forKey: KeychainKeyConstant.userId, withAccess: .accessibleWhenUnlocked)
                completion(result.user, nil)
            } catch {
                print(error)
                completion(nil, error)
            }
        }
    }
    
    func doSignUp(email: String, password: String, completion: @escaping (Void?, (any Error)?) -> Void) {
        Task {
            do {
                try await SupabaseSingleton.shared.client.auth.signUp(email: email, password: password)
                completion((), nil)
            } catch {
                completion(nil, error)
            }
        }
    }
}
