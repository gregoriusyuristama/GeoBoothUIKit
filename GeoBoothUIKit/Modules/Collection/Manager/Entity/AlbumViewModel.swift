//
//  AlbumViewModel.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 3/20/24.
//

import Foundation

struct AlbumViewModel {
    var albumName: String
    
    init(albumName: String) {
        self.albumName = albumName
    }
    
    init(album: AlbumDTO) {
        self.albumName = album.albumName
    }
}


