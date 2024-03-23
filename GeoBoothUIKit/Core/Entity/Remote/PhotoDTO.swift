//
//  PhotoDTO.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 3/20/24.
//

import Foundation

struct PhotoDTO: Codable {
    let id: Int
    var photoUrl: String
    var createdAt: Date?
    var albumId: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case photoUrl = "photo_url"
        case createdAt = "created_at"
        case albumId = "album_id"
    }
}

extension PhotoDTO {
    func toDomain() -> PhotoViewModel {
        return PhotoViewModel(photo: self)
    }
}
