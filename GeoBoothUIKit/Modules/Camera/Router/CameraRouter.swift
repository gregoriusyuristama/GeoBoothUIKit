//
//  CameraRouter.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 3/25/24.
//

import Foundation
import UIKit

class CameraRouter: CameraRouterProtocol {
    static func build(album: AlbumViewModel) -> UIViewController {
        let router = CameraRouter()
        
        var view: CameraViewProtocol = CameraViewController()
        var presenter: CameraPresenterProtocol = CameraPresenter()
        let manager: CameraManagerProtocol = CameraManager()
        var interactor: CameraInteractorProtocol = CameraInteractor(manager: manager)
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        interactor.album = album
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        guard let viewController = view as? UIViewController else { fatalError("Invalid UI Type") }
        
        return viewController
    }
    
    func popViewController(from view: any CameraViewProtocol) {
        guard let viewController = view as? UIViewController else { fatalError("Invalid View Controller Type") }
        
        viewController.navigationController?.popViewController(animated: true)
    }
}
