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
        let collectionManager: CollectionManagerProtocol = CollectionManager()
        var interactor: CollectionInteratorProtocol = CollectionInteractor(manager: collectionManager)
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor

        guard let viewCollection = view as? UIViewController else { fatalError("Invalid UI Type") }
        return factory(viewCollection, .collection)
    }
    
    func presentAddAlbumModal(from view: any CollectionViewProtocol) {
        guard 
            let viewController = view as? UIViewController & CollectionViewModalDismissalDelegate
        else { fatalError("Invalid View Controller type") }
        
        let addAlbumView = AddCollectionRouter.build(usingNavigationFactory: NavigationBuilder.build(rootView:type:), viewController: viewController)
        
        viewController.navigationController?.present(addAlbumView, animated: true)
    }
    
    func presentAlbumDetail(from view: any CollectionViewProtocol, album: AlbumViewModel) {
        guard
            let viewController = view as? UIViewController & CollectionViewModalDismissalDelegate
        else { fatalError("Invalid View Controller type") }
        
        let collectionDetailView = CollectionDetailRouter.build(album: album)
        viewController.navigationController?.pushViewController(collectionDetailView, animated: true)
        collectionDetailView.navigationItem.title = album.albumName
    }
    
}
