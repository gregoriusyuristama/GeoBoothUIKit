//
//  MapPresenter.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 3/21/24.
//

import Foundation

class MapPresenter: MapPresenterProtocol {
    var router: (any MapRouterProtocol)?
    
    var interactor: (any MapInteractorProtocol)? {
        didSet {
            interactor?.getMapLocations()
        }
    }
    
    var view: (any MapViewProtocol)?
    
    var isLoading: Bool = true {
        didSet {
            if isLoading {
                view?.updateViewIsLoading()
            } else {
                view?.updateViewIsNotLoading()
            }
        }
    }
    
    func interactorDidFetchMapLocations(with result: Result<[AlbumViewModel], any Error>) {
        isLoading = false
        switch result {
        case .success(let albums):
            view?.update(with: albums)
        case .failure(let failure):
            view?.update(with: failure.localizedDescription)
        }
    }
}
