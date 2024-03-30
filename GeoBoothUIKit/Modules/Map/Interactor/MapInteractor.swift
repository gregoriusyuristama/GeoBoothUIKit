//
//  MapInteractor.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 3/21/24.
//

import Foundation

class MapInteractor: MapInteractorProtocol {
    var manager: (any MapManagerProtocol)?

    var presenter: (any MapPresenterProtocol)?

    init(manager: (any MapManagerProtocol)? = nil) {
        self.manager = manager
    }

    func getMapLocations() {
        manager?.getRemoteMapLocations(completion: { result in
            switch result {
            case .success(let albums):
                let albumVM = albums.map { $0.toDomain() }
                self.presenter?.interactorDidFetchMapLocations(with: .success(albumVM))
            case .failure(let failure):
                self.presenter?.interactorDidFetchMapLocations(with: .failure(failure))
            }
        })
    }
}
