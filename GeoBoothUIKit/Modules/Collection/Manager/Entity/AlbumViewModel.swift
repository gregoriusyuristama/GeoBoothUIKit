//
//  AlbumViewModel.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 3/20/24.
//

import Foundation

struct AlbumViewModel {
    let id: Int
    var albumName: String
    var latitude: Double
    var longitude: Double
    var photos: [PhotoViewModel]
}
