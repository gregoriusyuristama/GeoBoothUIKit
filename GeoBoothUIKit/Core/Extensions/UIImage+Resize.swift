//
//  UIImage+Resize.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 2/7/24.
//

import Foundation
import UIKit
extension UIImage {
    func resizeImage(scaledToSize newSize: CGSize) -> UIImage? {
        // UIGraphicsBeginImageContext(newSize);
        // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
        // Pass 1.0 to force exact pixel size.
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
