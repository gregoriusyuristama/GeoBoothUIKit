//
//  CameraManager.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 3/25/24.
//

import Foundation
import Supabase
import KeychainSwift

class CameraManager: CameraManagerProtocol {
    func savePhoto(imageData: Data, album: AlbumViewModel, completion: @escaping (Result<Void, any Error>) -> Void) {
        
        let keychain = KeychainSwift()
        
        guard let uid = keychain.get(KeychainKeyConstant.userId) else { return }
        let imagePath = StorageNameConstant.Path.uidPhotoPath(
            uid: uid
        )
        Task {
            do {
                try await SupabaseSingleton
                    .shared
                    .client
                    .storage
                    .from(StorageNameConstant.geoBooth)
                    .upload(
                        path: imagePath,
                        file: imageData,
                        options: FileOptions(
                            cacheControl: "3600",
                            contentType: "image/jpeg"
                        )
                    )
                
                try await SupabaseSingleton
                    .shared
                    .client
                    .database
                    .from(TableName.photo)
                    .insert(
                        InsertPhotoDTO(
                            photoUrl: SupabaseSingleton
                                .shared
                                .client
                                .storage
                                .from(StorageNameConstant.geoBooth)
                                .getPublicURL(path: imagePath).absoluteString, 
                            albumId: album.id
                        )
                    )
                    .single()
                    .execute()
                
                completion(
                    .success( () )
                )
            } catch {
                completion(
                    .failure(error)
                )
            }
        }
        
    }
}
