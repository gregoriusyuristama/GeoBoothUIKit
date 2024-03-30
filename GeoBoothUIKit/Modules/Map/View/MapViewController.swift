//
//  CollectionViewController.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 2/7/24.
//

import MapKit
import UIKit

class MapViewController: UIViewController {
    var presenter: (any MapPresenterProtocol)?
    
    let mapView = MKMapView()
    
    private var spinner = LoadingViewController()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .systemBackground
        setupMapView()
        setupLocationManager()
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
        mapView.register(AlbumAnnotationView.self, forAnnotationViewWithReuseIdentifier: AlbumAnnotationView.identifier)
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

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: any MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        if let albumAnnotation = annotation as? AlbumAnnotation {
            return AlbumAnnotationView(
                annotation: albumAnnotation,
                reuseIdentifier: AlbumAnnotationView.identifier,
                imageUrl: albumAnnotation.imageUrl)
        }
        
        return nil
    }
}

extension MapViewController: MapViewProtocol {
    func update(with albums: [AlbumViewModel]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            for album in albums {
                let annotation = AlbumAnnotation(
                    coordinate: CLLocationCoordinate2D(
                        latitude: album.latitude,
                        longitude: album.longitude
                    ),
                    imageUrl: album.photos.last?.photoUrl,
                    albumName: album.albumName,
                    photosCount: album.photos.count
                )
                self.mapView.addAnnotation(annotation)
            }
        }
    }
    
    func update(with error: String) {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self?.present(alert, animated: true, completion: nil)
        }
    }
    
    func updateViewIsLoading() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.addChild(self.spinner)
            self.spinner.view.frame = self.view.frame
            self.view.addSubview(self.spinner.view)
            self.spinner.didMove(toParent: self)
        }
    }
    
    func updateViewIsNotLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.spinner.willMove(toParent: nil)
            self?.spinner.view.removeFromSuperview()
            self?.spinner.removeFromParent()
        }
    }
}
