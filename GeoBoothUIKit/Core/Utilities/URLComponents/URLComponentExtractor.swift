//
//  URLComponentExtractor.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 3/28/24.
//

import Foundation

extension String {
    func extractGeoboothPathComponent() -> String? {
        guard let url = URL(string: self),
              let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
              let path = components.path.components(separatedBy: "\(StorageNameConstant.geoBooth)/").last else {
            return nil
        }
        return path
    }
}
