//
//  CollectionDetailPresenter.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 3/23/24.
//

import Foundation
import UIKit

class CollectionDetailPresenter: CollectionDetailPresenterProtocol {
    var router: (any CollectionDetailRouterProtocol)?
    
    var interactor: (any CollectionDetailInteractorProtocol)? {
        didSet {
            interactor?.getPhotos()
            interactor?.getRegion()
        }
    }
    
    var view: (any CollectionDetailViewProtocol)?
    
    var isLoading: Bool = false {
        didSet {
            if isLoading {
                view?.updateViewIsLoading()
            } else {
                view?.updateViewIsNotLoading()
            }
        }
    }
    
    var isInRegion: Bool = false {
        didSet {
            if isInRegion {
                view?.updateCameraInRegion()
            } else {
                view?.updateCameraOutRegion()
            }
        }
    }
    
    func editAlbum(newAlbumName: String) {
        isLoading = true
        interactor?.editAlbum(newAlbumName: newAlbumName)
    }
    
    func deleteAlbum() {
        isLoading = true
        interactor?.deleteAlbum()
    }
    
    func updateViewSuccess(newAlbumName: String) {
        isLoading = false
        view?.updateViewSuccess(newAlbumName: newAlbumName)
    }
    
    func updateViewFailed(errorMessage: String) {
        isLoading = false
        view?.updateViewFailed(errorMessage: errorMessage)
    }
    
    func updateViewDeleteSuccess() {
        isLoading = false
        view?.updateViewDeleteSuccess()
    }
    
    func interactorDidFetchPhotos(with photos: [PhotoViewModel]) {
        view?.displayPhotos(photos: photos)
    }
    
    func viewWillDissappear() {
        interactor?.stopMonitoringRegion()
    }
    
    func presentCameraView() {
        guard
            let view = view,
            let album = interactor?.album
        else {
            fatalError("Empty View")
        }
        router?.showCameraView(
            from: view,
            album: album
        )
    }
    
    func presentFullImage(image: UIImage, selector: Selector) {
        guard let view = view else { fatalError("Empty View on Presenter") }
        router?.showFullImage(from: view, image: image, selector: selector)
    }
    
    func triggerPhotosUpdate() {
        interactor?.fetchPhotos()
    }
    
    func triggerPhotoDeletion(photo: PhotoViewModel) {
        interactor?.deletePhoto(photo: photo)
    }
    
}
