//
//  AddCollectionManager.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 3/19/24.
//

import Foundation
import KeychainSwift

class AddCollectionManager: AddCollectionManagerProtocol {
    func addAlbum(albumName: String, completion: @escaping(Result<Void, Error>) -> Void) {
        let keychain = KeychainSwift()
        guard
            let userId = UUID(uuidString: keychain.get(KeychainKeyConstant.userId) ?? ""),
            let latitude = LocationServices.shared.currentLocation?.latitude,
            let longitude = LocationServices.shared.currentLocation?.longitude
        else { return }
        Task {
            do {
                try await SupabaseSingleton
                    .shared
                    .client
                    .database
                    .rpc(
                        DbFunction.addAlbum,
                        params: InsertAlbumDTO(
                            albumName: albumName,
                            latitude: latitude,
                            longitude: longitude,
                            userId: userId
                        )
                    )
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
