//
//  CollectionInteractor.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 3/14/24.
//

import Foundation

class CollectionInteractor: CollectionInteratorProtocol {
    var manager: any CollectionManagerProtocol

    var presenter: (any CollectionPresenterProtocol)?

    init(manager: any CollectionManagerProtocol) {
        self.manager = manager
    }

    func getAlbums() {
        manager.getRemoteAlbums { result in
            switch result {
            case .success(let albumsDTO):
                let albums = albumsDTO.map { $0.toDomain() }
                print(albums)
                self.presenter?.interactorDidFetchAlbums(with: .success(albums))
            case .failure(let failure):
                self.presenter?.interactorDidFetchAlbums(with: .failure(failure))
            }
        }
    }
}
