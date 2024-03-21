//
//  AddCollectionPresenter.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 3/19/24.
//

import Foundation

class AddCollectionPresenter: AddCollectionPresenterProtocol {
    var router: (any AddCollectionRouterProtocol)?
    
    var interactor: (any AddCollectionInteratorProtocol)?
    
    var view: (any AddCollectionViewProtocol)?
    
    var isLoading: Bool = false {
        didSet {
            if isLoading {
                view?.updateViewIsLoading()
            } else {
                view?.updateViewIsNotLoading()
            }
        }
    }
    
    func addAlbum(albumName: String) {
        isLoading = true
        interactor?.addAlbum(albumName: albumName)
    }
    
    func addAlbumSuccess() {
        isLoading = false
        view?.updateViewAddSuccess()
    }
    
    func addAlbumFailed(errorMessage: String) {
        isLoading = false
        view?.updateViewAddFailed(errorMessage: errorMessage)
    }
    
}
