//
//  AddCollectionPresenter.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 3/19/24.
//

import Foundation

class AddCollectionInteractor: AddCollectionInteratorProtocol {
    var presenter: (any AddCollectionPresenterProtocol)?
    
    var manager: any AddCollectionManagerProtocol
    
    init(manager: any AddCollectionManagerProtocol) {
        self.manager = manager
    }
    
    func addAlbum(albumName: String) {
        manager.addAlbum(albumName: albumName, completion: { result in
            switch result {
            case .success():
                self.presenter?.addAlbumSuccess()
            case .failure(let failure):
                self.presenter?.addAlbumFailed(errorMessage: failure.localizedDescription)
            }
        })
    }
    
}
