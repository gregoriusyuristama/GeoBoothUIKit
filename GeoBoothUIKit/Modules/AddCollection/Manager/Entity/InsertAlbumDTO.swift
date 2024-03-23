//
//  InsertAlbumDTO.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 3/23/24.
//

import Foundation

struct InsertAlbumDTO: Codable {
    let albumName: String
    let latitude: Double
    let longitude: Double
    let userId: UUID

    enum CodingKeys: String, CodingKey {
        case albumName = "album_name"
        case latitude, longitude
        case userId = "user_id"
    }
}
