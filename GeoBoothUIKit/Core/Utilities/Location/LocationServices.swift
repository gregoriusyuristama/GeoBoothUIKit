//
//  LocationServices.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 2/9/24.
//

import Foundation
import CoreLocation

class LocationServices: NSObject, CLLocationManagerDelegate {
    public static let shared = LocationServices()
    let locationManager = CLLocationManager()
    var currentLocation: CLLocationCoordinate2D?
    var changeAuthDelegate: ChangeAuthDelegate?
    
    private override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = manager.location?.coordinate
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if changeAuthDelegate != nil {
            if #available(iOS 14.0, *) {
                changeAuthDelegate?.authorizationChanged(authStatus: manager.authorizationStatus)
            } else {
                // Fallback on earlier versions
                changeAuthDelegate?.authorizationChanged(authStatus: CLLocationManager.authorizationStatus())
            }
        }
    }
    
}
