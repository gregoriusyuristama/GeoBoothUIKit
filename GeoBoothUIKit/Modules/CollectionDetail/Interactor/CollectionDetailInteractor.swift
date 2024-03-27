//
//  CollectionDetailInteractor.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 3/23/24.
//

import CoreLocation
import Foundation
import KeychainSwift

class CollectionDetailInteractor: CollectionDetailInteractorProtocol {
    var album: AlbumViewModel
    
    var presenter: (any CollectionDetailPresenterProtocol)?

    var manager: (any CollectionDetailManagerProtocol)?
    
    init(
        manager: (any CollectionDetailManagerProtocol)? = nil,
        album: AlbumViewModel
    ) {
        self.manager = manager
        self.album = album
    }
    
    func editAlbum(newAlbumName: String) {
        let updatedAlbum = UpdateAlbumDTO(
            albumId: album.id,
            albumName: newAlbumName
        )
        manager?.editAlbum(album: updatedAlbum, completion: { result in
            switch result {
            case .success:
                self.presenter?.updateViewSuccess(newAlbumName: newAlbumName)
            case .failure(let failure):
                self.presenter?.updateViewFailed(errorMessage: failure.localizedDescription)
            }
        })
    }
    
    func deleteAlbum() {
        manager?.deleteAlbum(album: album, completion: { result in
            switch result {
            case .success:
                self.presenter?.updateViewDeleteSuccess()
            case .failure(let failure):
                self.presenter?.updateViewFailed(errorMessage: failure.localizedDescription)
            }
        })
    }
    
    func getPhotos() {
        presenter?.interactorDidFetchPhotos(with: album.photos)
    }
    
    func getRegion() {
        LocationServices.shared.regionMovementDelegate = self
        startMonitoringAlbumRegion()
    }
    
    private func startMonitoringAlbumRegion() {
        let region = CLCircularRegion(
            center: CLLocationCoordinate2D(
                latitude: album.latitude,
                longitude: album.longitude
            ),
            radius: 150,
            identifier: "\(album.id)"
        )
        LocationServices.shared.startMonitoring(region: region)
        
        getInitialLocationCheck(album.latitude, album.longitude)
    }
    
    private func getInitialLocationCheck(_ latitude: Double, _ longitude: Double) {
        guard
            let currentLongitude = LocationServices.shared.currentLocation?.longitude,
            let currentLatitude = LocationServices.shared.currentLocation?.latitude
        else { return }
        
        if CLLocation(
            latitude: latitude,
            longitude: longitude
        )
        .distance(from: CLLocation(latitude: currentLatitude, longitude: currentLongitude)) < 150 {
            presenter?.isInRegion = true
        } else {
            presenter?.isInRegion = false
        }
    }
    
    func stopMonitoringRegion() {
        let region = CLCircularRegion(
            center: CLLocationCoordinate2D(
                latitude: album.latitude,
                longitude: album.longitude
            ),
            radius: 150,
            identifier: "\(album.id)"
        )
        LocationServices.shared.stopMonitoring(region: region)
    }
}

extension CollectionDetailInteractor: RegionMovementDelegate {
    func didEnterRegion() {
        presenter?.isInRegion = true
    }
    
    func didExitRegion() {
        presenter?.isInRegion = false
    }
}

protocol RegionMovementDelegate: AnyObject {
    func didEnterRegion()
    func didExitRegion()
}
