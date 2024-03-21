//
//  AlbumDTO.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 3/20/24.
//

import Foundation

struct AlbumDTO: Codable {
    let id: Int?
    var albumName: String
    var latitude: Double
    var longitude: Double
    var createdAt: Date?
    var userId: UUID
    
    enum CodingKeys: String, CodingKey {
        case id
        case albumName = "album_name"
        case latitude, longitude
        case createdAt = "created_at"
        case userId = "user_id"
    }
}

extension AlbumDTO {
    func toDomain() -> AlbumViewModel {
        AlbumViewModel(album: self)
    }
}
