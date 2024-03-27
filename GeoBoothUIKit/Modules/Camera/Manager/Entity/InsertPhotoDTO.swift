//
//  InsertPhotoDTO.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 3/27/24.
//

import Foundation

struct InsertPhotoDTO: Codable {
    let photoUrl: String
    let albumId: Int
    
    enum CodingKeys: String, CodingKey {
        case photoUrl = "photo_url"
        case albumId = "album_id"
    }
}
