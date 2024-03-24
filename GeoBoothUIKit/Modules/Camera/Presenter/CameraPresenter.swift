//
//  CameraPresenter.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 3/25/24.
//

import Foundation

class CameraPresenter: CameraPresenterProtocol {
    var router: (any CameraRouterProtocol)?
    
    var interactor: (any CameraInteractorProtocol)?
    
    var view: (any CameraViewProtocol)?
    
    func doSavePhoto(imageData: Data) {
        interactor?.savePhoto(imageData: imageData)
    }
    
}
