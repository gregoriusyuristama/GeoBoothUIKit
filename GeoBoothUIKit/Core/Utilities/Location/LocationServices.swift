//
//  LocationServices.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 2/9/24.
//

import CoreLocation
import Foundation

class LocationServices: NSObject, CLLocationManagerDelegate {
    public static let shared = LocationServices()
    let locationManager = CLLocationManager()
    var currentLocation: CLLocationCoordinate2D?
    var changeAuthDelegate: ChangeAuthDelegate?
    var regionMovementDelegate: RegionMovementDelegate?
    
    override private init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        currentLocation = locationManager.location?.coordinate
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
    
    func startMonitoring(region: CLRegion) {
        region.notifyOnExit = true
        region.notifyOnEntry = true
        locationManager.startMonitoring(for: region)
    }
    
    func stopMonitoring(region: CLRegion) {
        region.notifyOnExit = false
        region.notifyOnEntry = false
        locationManager.stopMonitoring(for: region)
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        regionMovementDelegate?.didEnterRegion()
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        regionMovementDelegate?.didExitRegion()
    }
}
