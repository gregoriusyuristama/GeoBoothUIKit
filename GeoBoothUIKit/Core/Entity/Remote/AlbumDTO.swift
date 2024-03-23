//
//  AlbumDTO.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 3/20/24.
//

import Foundation

struct AlbumDTO: Codable {
    let id: Int?
    var name: String
    var latitude: Double?
    var longitude: Double?
    var createdAt: Date?
    var userId: UUID
    var photos: [PhotoDTO]?

    enum CodingKeys: String, CodingKey {
        case id, name, latitude, longitude
        case createdAt = "created_at"
        case userId = "user_id"
        case photos = "photo"
    }
}

extension AlbumDTO {
    func toDomain() -> AlbumViewModel {
        guard let photos = self.photos?.map({ $0.toDomain() }) else { fatalError("failed to parse photos") }

        let album = AlbumViewModel(
            id: self.id!,
            albumName: self.name,
            latitude: self.latitude!,
            longitude: self.longitude!,
            photos: photos
        )
        return album
    }
}
