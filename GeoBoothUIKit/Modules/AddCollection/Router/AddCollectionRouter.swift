//
//  AddCollectionRouter.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 3/19/24.
//

import Foundation
import UIKit

class AddCollectionRouter: AddCollectionRouterProtocol {
    static func build(usingNavigationFactory factory: (UIViewController) -> (UINavigationController)) -> UIViewController {
        let router = AddCollectionRouter()
        
        var view: AddCollectionViewProtocol = AddAlbumViewController()
        var presenter: AddCollectionPresenterProtocol = AddCollectionPresenter()
        var interactor: AddCollectionInteratorProtocol = AddCollectionInteractor()
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        guard let viewController = view as? UIViewController else { fatalError("Invalid UI Type") }
        
        viewController.navigationItem.title = "Add New Album"
        
        return factory(viewController)
    }
    
}
