//
//  CollectionRouter.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 3/13/24.
//

import Foundation
import UIKit

class CollectionRouter: CollectionRouterProtocol {
    static func build(usingNavigationFactory factory: NavigationFactory) -> UIViewController {
        let router = CollectionRouter()
        
        var view: CollectionViewProtocol = CollectionViewController()
        var presenter: CollectionPresenterProtocol = CollectionPresenter()
        var interactor: CollectionInteratorProtocol = CollectionInteractor()
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor

        guard let viewCollection = view as? UIViewController else { fatalError("Invalid UI Type") }
        
        viewCollection.navigationController?.navigationBar.prefersLargeTitles = true
        viewCollection.navigationItem.title = "GeoBooth"
        
        return factory(viewCollection)
    }
    
    func presentAddAlbumModal(from view: any CollectionViewProtocol) {
        let addAlbumView = AddCollectionRouter.build(usingNavigationFactory: NavigationBuilder.build(rootView:))
        
        guard let viewController = view as? UIViewController else { fatalError("Invalid View Controller type") }
        
        viewController.navigationController?.present(addAlbumView, animated: true)
    }
    
}
