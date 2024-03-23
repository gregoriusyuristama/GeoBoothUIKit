//
//  CollectionDetailManager.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 3/23/24.
//

import Foundation

class CollectionDetailManager: CollectionDetailManagerProtocol {
    func editAlbum(album: UpdateAlbumDTO, completion: @escaping ((Result<Void, any Error>) -> Void)) {
        Task {
            do {
                try await SupabaseSingleton
                    .shared
                    .client
                    .database
                    .rpc(
                        DbFunction.editAlbum,
                        params: album
                    )
                    .execute()
                completion(
                    .success(())
                )
            } catch {
                completion(.failure(error))
            }
        }
    }

    func deleteAlbum(album: AlbumViewModel, completion: @escaping ((Result<Void, any Error>) -> Void)) {
        Task {
            do {
                try await SupabaseSingleton
                    .shared
                    .client
                    .database
                    .from(TableName.album)
                    .delete()
                    .eq("id", value: album.id)
                    .execute()
                completion(
                    .success( () )
                )
            } catch {
                completion(.failure(error))
            }
        }
    }
}
