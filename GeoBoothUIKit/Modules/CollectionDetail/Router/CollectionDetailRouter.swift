//
//  CollectionDetailRouter.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 3/23/24.
//

import Foundation
import UIKit

class CollectionDetailRouter: CollectionDetailRouterProtocol {
    static func build(album: AlbumViewModel) -> UIViewController {
        let router = CollectionDetailRouter()
        
        var view: CollectionDetailViewProtocol = CollectionDetailViewController()
        var presenter: CollectionDetailPresenterProtocol = CollectionDetailPresenter()
        let manager: CollectionDetailManagerProtocol = CollectionDetailManager()
        var interactor: CollectionDetailInteractorProtocol = CollectionDetailInteractor(manager: manager, album: album)
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        guard let viewController = view as? UIViewController else { fatalError("Invalid UI Type") }
        
        return viewController
    }
    
    func showCameraView(from view: any CollectionDetailViewProtocol, album: AlbumViewModel) {
        guard let viewController = view as? UIViewController else { fatalError("Invalid View Controller type") }
        
        let cameraView = CameraRouter.build(album: album)
        
        viewController.navigationController?.pushViewController(cameraView, animated: true)
    }
    
    func showFullImage(from view: any CollectionDetailViewProtocol, image: UIImage, selector: Selector) {
        guard let viewController = view as? UIViewController else { fatalError("Invalid View Controller Type") }
        
        let fullImageVc = FullImageViewController()
        fullImageVc.image = image
        let deleteButton = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: viewController, action: selector)
        fullImageVc.navigationItem.rightBarButtonItem = deleteButton
        
        viewController.navigationController?.pushViewController(fullImageVc, animated: true)
        
    }
    
}
