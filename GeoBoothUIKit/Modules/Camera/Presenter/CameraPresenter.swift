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
    
    var isLoading: Bool = false {
        didSet {
            if isLoading {
                view?.updateViewIsLoading()
            } else {
                view?.updateViewIsNotLoading()
            }
        }
    }
    
    func doSavePhoto(imageData: Data) {
        isLoading = true
        interactor?.savePhoto(imageData: imageData)
    }

    func savePhotoSuccess() {
        isLoading = false
        view?.updateViewSavePhotoSuccess()
    }
    
    func savePhotoFailed(errorMessage: String) {
        isLoading = false
        view?.updateViewSavePhotoFailed(
            errorMessage: errorMessage
        )
    }

    func popViewController() {
        guard let view = view else { fatalError("Empty View on Camera Presenter") }
        router?.popViewController(from: view)
    }
    
}
