//
//  PhotoViewModel.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 3/20/24.
//

import Foundation

struct PhotoViewModel {
    var photoUrl: String
    
    init(photoUrl: String) {
        self.photoUrl = photoUrl
    }
    
    init(photo: PhotoDTO) {
        self.photoUrl = photo.photoUrl
    }
}
