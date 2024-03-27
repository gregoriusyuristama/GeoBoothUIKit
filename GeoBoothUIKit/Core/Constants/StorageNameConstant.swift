//
//  StorageNameConstant.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 3/27/24.
//

import Foundation

enum StorageNameConstant {
    static let geoBooth = "geobooth"

    enum Path {
        static func uidPhotoPath(uid: String) -> String {
            let generatedFileName = Date().timeIntervalSince1970.description
            
            return "\(uid)/photos/\(generatedFileName)"
        }
    }
}
