//
//  CameraInteractor.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 3/25/24.
//

import Foundation

class CameraInteractor: CameraInteractorProtocol {
    var presenter: (any CameraPresenterProtocol)?
    
    var manager: (any CameraManagerProtocol)?
    
    init(manager: (any CameraManagerProtocol)? = nil) {
        self.manager = manager
    }
    
    func savePhoto(imageData: Data) {
        manager?.savePhoto(imageData: imageData, completion: { result in
            switch result {
            case .success(let success):
                print("success")
            case .failure(let failure):
                print("failure")
            }
        })
    }
    
}
