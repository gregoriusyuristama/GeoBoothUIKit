//
//  AuthenticationInteractor.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 3/13/24.
//

import Foundation
import Auth

class AuthenticationInteractor: AuthenticationInteractorProtocol {
    
    var presenter: (any AuthenticationPresenterProtocol)?
    
    func doAuth(email: String, password: String, completion: @escaping (User?, Error?) -> Void) {
        Task {
            do {
                var result = try await SupabaseSingleton
                    .shared.client
                    .auth.signIn(
                        email: email,
                        password: password
                    )
                print(result)
                UserDefaultHelper.saveWithJson(result, with: UserDefaultsKeyConstant.supabaseSession)
                completion(result.user, nil)
            } catch {
                print(error)
                completion(nil, error)
            }
        }
    }
    
}
