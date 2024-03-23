//
//  CollectionDetailPresenter.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 3/23/24.
//

import Foundation

class CollectionDetailPresenter: CollectionDetailPresenterProtocol {
    var router: (any CollectionDetailRouterProtocol)?
    
    var interactor: (any CollectionDetailInteractorProtocol)? {
        didSet {
            interactor?.getPhotos()
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
}
