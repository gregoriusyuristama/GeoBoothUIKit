//
//  CollectionManager.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 3/14/24.
//

import Foundation
import KeychainSwift

class CollectionManager: CollectionManagerProtocol {
    func getRemoteAlbums(completion: @escaping ((Result<[AlbumDTO], any Error>) -> Void)) {
        let keychain = KeychainSwift()
        guard let userId = keychain.get(KeychainKeyConstant.userId) else { return }
        Task {
            do {
                let query = await SupabaseSingleton
                    .shared
                    .client
                    .database
                    .from(TableName.album)
                    .select(
                        """
                        id,
                        album_name,
                        latitude,
                        longitude,
                        created_at,
                        user_id
                        """
                    )
                    .eq(
                        "user_id",
                        value: userId
                    )
                let response: [AlbumDTO] = try await query
                    .execute()
                    .value
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
