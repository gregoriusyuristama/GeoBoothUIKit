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
        var interactor: CollectionDetailInteractorProtocol = CollectionDetailInteractor(manager: manager)
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        interactor.album = album
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        guard let viewController = view as? UIViewController else { fatalError("Invalid UI Type") }
        
        return viewController
    }
}
