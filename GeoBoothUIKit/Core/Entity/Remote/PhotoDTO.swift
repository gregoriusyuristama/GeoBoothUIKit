//
//  PhotoDTO.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 3/20/24.
//

import Foundation

struct PhotoDTO: Decodable {
    let id: Int
    var photoUrl: String
    var createdAt: Date
    var albumId: Int
}

extension PhotoDTO {
    func toDomain() -> PhotoViewModel {
        return PhotoViewModel(photo: self)
    }
}
