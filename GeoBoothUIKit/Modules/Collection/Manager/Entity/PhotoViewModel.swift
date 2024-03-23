//
//  PhotoViewModel.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 3/20/24.
//

import Foundation

struct PhotoViewModel {
    var id: Int
    var photoUrl: String
    
    init(photo: PhotoDTO) {
        self.id = photo.id
        self.photoUrl = photo.photoUrl
    }
}
