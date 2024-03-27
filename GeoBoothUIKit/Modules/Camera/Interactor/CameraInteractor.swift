//
//  CameraInteractor.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 3/25/24.
//

import Foundation

class CameraInteractor: CameraInteractorProtocol {
    var album: AlbumViewModel?
    
    var presenter: (any CameraPresenterProtocol)?
    
    var manager: (any CameraManagerProtocol)?
    
    init(manager: (any CameraManagerProtocol)? = nil) {
        self.manager = manager
    }
    
    func savePhoto(imageData: Data) {
        guard let album = album else { return }
        manager?.savePhoto(imageData: imageData, album: album, completion: { result in
            switch result {
            case .success:
                self.presenter?.savePhotoSuccess()
            case .failure(let failure):
                self.presenter?.savePhotoFailed(
                    errorMessage: failure.localizedDescription
                )
            }
        })
    }
}
