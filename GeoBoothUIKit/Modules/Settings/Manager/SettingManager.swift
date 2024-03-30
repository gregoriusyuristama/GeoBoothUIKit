//
//  SettingManager.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 3/31/24.
//

import Foundation
import Supabase
import KeychainSwift

class SettingManager: SettingManagerProtocol {
    func logout(completion: @escaping (Result<Void, any Error>) -> Void) {
        let keychain = KeychainSwift()
        Task {
            do {
                try await SupabaseSingleton.shared.client.auth.signOut()
                keychain.clear()
                completion(.success(()))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
