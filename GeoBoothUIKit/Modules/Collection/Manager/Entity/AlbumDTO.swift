//
//  AlbumDTO.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 3/20/24.
//

import Foundation

struct AlbumDTO: Decodable {
    let id: Int
    var albumName: String
    var latitude: Double
    var longitude: Double
    var createdAt: Date
    var userId: UUID
}

extension AlbumDTO {
    func toDomain() -> AlbumViewModel {
        AlbumViewModel(album: self)
    }
}
