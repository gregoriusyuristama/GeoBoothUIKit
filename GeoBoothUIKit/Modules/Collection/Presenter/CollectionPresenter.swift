//
//  CollectionPresenter.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 3/14/24.
//

import Foundation

class CollectionPresenter: CollectionPresenterProtocol {
    var router: (any CollectionRouterProtocol)?
    
    var interactor: (any CollectionInteratorProtocol)? {
        didSet {
            interactor?.getAlbums()
        }
    }
    
    var view: (any CollectionViewProtocol)?
    
    var isLoading: Bool = true {
        didSet {
            if isLoading {
                view?.updateViewIsLoading()
            } else {
                view?.updateViewIsNotLoading()
            }
        }
    }

    func showAddAlbumModal() {
        guard let view = view else { return }
        router?.presentAddAlbumModal(from: view)
    }
    
    func showAlbumDetail(album: AlbumViewModel) {
        guard let view = view else { return }
        router?.presentAlbumDetail(from: view, album: album)
    }
    
    func interactorDidFetchAlbums(with result: Result<[AlbumViewModel], any Error>) {
        isLoading = false
        switch result {
        case .success(let albums):
            view?.update(with: albums)
        case .failure(let error):
            view?.update(with: error.localizedDescription)
        }
    }
    
    func triggerFetchAlbum() {
        interactor?.getAlbums()
    }
    
}
