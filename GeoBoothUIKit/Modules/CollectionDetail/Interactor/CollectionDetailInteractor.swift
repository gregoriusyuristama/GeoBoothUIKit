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
    var album: AlbumViewModel?
    
    var presenter: (any CollectionDetailPresenterProtocol)?

    var manager: (any CollectionDetailManagerProtocol)?
    
    init(manager: (any CollectionDetailManagerProtocol)? = nil) {
        self.manager = manager
    }
    
    func editAlbum(newAlbumName: String) {
        guard let album = album
        else { fatalError("Empty album on interactor") }
        
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
        guard let album = album
        else { fatalError("Empty album on interactor") }
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
        presenter?.interactorDidFetchPhotos(with: album?.photos ?? [])
    }
    
    func getRegion() {
        LocationServices.shared.regionMovementDelegate = self
        startMonitoringAlbumRegion()
    }
    
    private func startMonitoringAlbumRegion() {
        guard
            let albumLatitude = album?.latitude,
            let albumLongitude = album?.longitude,
            let albumId = album?.id
        else {
            return
        }
        let region = CLCircularRegion(
            center: CLLocationCoordinate2D(latitude: albumLatitude, longitude: albumLongitude),
            radius: 150,
            identifier: "\(albumId)"
        )
        LocationServices.shared.startMonitoring(region: region)
        
        getInitialLocationCheck(albumLatitude, albumLongitude)
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
        guard
            let albumLatitude = album?.latitude,
            let albumLongitude = album?.longitude,
            let albumId = album?.id
        else {
            return
        }
        
        let region = CLCircularRegion(
            center: CLLocationCoordinate2D(latitude: albumLatitude, longitude: albumLongitude),
            radius: 150,
            identifier: "\(albumId)"
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
