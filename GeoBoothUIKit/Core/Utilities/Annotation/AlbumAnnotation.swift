//
//  AlbumAnnotation.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 3/31/24.
//

import Foundation
import MapKit

class AlbumAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var imageUrl: String?
    var albumName: String?
    var photosCount: Int?
    
    init(coordinate: CLLocationCoordinate2D, imageUrl: String? = nil, albumName: String? = nil, photosCount: Int? = nil) {
        self.coordinate = coordinate
        self.imageUrl = imageUrl
        self.albumName = albumName
        self.photosCount = photosCount
    }
    
}
