//
//  CollectionViewController.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 2/7/24.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    let mapView = MKMapView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = .systemBackground
        self.setupMapView()
        self.setupLocationManager()
    }
    
    fileprivate func setupMapView() {
        let safeArea = view.safeAreaLayoutGuide
        
        mapView.mapType = MKMapType.standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.center = view.center
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.delegate = self
        mapView.showsUserLocation = true
        if #available(iOS 17.0, *) {
            mapView.showsUserTrackingButton = true
        } else {
            // Fallback on earlier versions
        }
        
        view.addSubview(mapView)
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
    
    fileprivate func setupLocationManager() {
        LocationServices.shared.locationManager.requestWhenInUseAuthorization()
        LocationServices.shared.changeAuthDelegate = self
    }
    
    func followUserIfPossible(authStatus: CLAuthorizationStatus) {
        if authStatus == .authorizedWhenInUse {
            mapView.setUserTrackingMode(.follow, animated: true)
        } else if authStatus == .authorizedAlways {
            LocationServices.shared.locationManager.allowsBackgroundLocationUpdates = true
            mapView.setUserTrackingMode(.follow, animated: true)
        }
    }
    
}

extension MapViewController: ChangeAuthDelegate {
    func authorizationChanged(authStatus: CLAuthorizationStatus) {
        followUserIfPossible(authStatus: authStatus)
    }
    
}
