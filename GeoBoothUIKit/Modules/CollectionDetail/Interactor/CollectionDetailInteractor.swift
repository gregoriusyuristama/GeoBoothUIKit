//
//  CollectionDetailInteractor.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 3/23/24.
//

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
            case .success(_):
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
            case .success(let success):
                self.presenter?.updateViewDeleteSuccess()
            case .failure(let failure):
                self.presenter?.updateViewFailed(errorMessage: failure.localizedDescription)
            }
        })
    }
}
