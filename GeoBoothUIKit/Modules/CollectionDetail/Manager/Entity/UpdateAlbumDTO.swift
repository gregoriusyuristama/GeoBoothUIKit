//
//  UpdateAlbumDTO.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 3/23/24.
//

import Foundation

struct UpdateAlbumDTO: Codable {
    let albumId: Int
    let albumName: String
    
    enum CodingKeys: String, CodingKey {
        case albumId = "album_id"
        case albumName = "album_name"
    }
}
