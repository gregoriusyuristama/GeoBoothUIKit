//
//  CollectionDetailManager.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 3/23/24.
//

import Foundation
import Supabase

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
                    .success(())
                )
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func fetchPhotos(album: AlbumViewModel, completion: @escaping ((Result<[PhotoDTO], any Error>) -> Void)) {
        Task {
            do {
                let query = await SupabaseSingleton
                    .shared
                    .client
                    .database
                    .from(TableName.photo)
                    .select()
                    .eq("album_id", value: album.id)
                
                let response: [PhotoDTO] = try await query.execute().value
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func deletePhoto(album: AlbumViewModel, photo: PhotoViewModel, completion: @escaping (Result<Void, any Error>) -> Void) {
        guard let imagePath = photo.photoUrl.extractGeoboothPathComponent() else { return }
        
        print(imagePath)
        print(photo)
        Task {
            do {
                _  = try await SupabaseSingleton
                    .shared
                    .client
                    .storage
                    .from(StorageNameConstant.geoBooth)
                    .remove(paths: [
                        imagePath
                    ])
                
                try await SupabaseSingleton
                    .shared
                    .client
                    .database
                    .from(TableName.photo)
                    .delete()
                    .eq("id", value: photo.id)
                    .execute()
                
                completion( .success( () ) )
            } catch {
                completion(
                    .failure(error)
                )
            }
        }
    }
}
