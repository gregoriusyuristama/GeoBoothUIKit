//
//  CustomUserLocationDelegate.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 2/9/24.
//

import Foundation
import CoreLocation

protocol ChangeAuthDelegate: AnyObject {
    func authorizationChanged(authStatus: CLAuthorizationStatus)
}
