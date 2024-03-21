//
//  MapRouter.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 3/13/24.
//

import Foundation
import UIKit

class MapRouter: MapRouterProtocol {
    static func build(usingNavigationFactory factory: NavigationFactory) -> UIViewController {
        let router = MapRouter()
        
        var view: MapViewProtocol = MapViewController()
        var presenter: MapPresenterProtocol = MapPresenter()
        var interactor: MapInteractorProtocol = MapInteractor()
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        guard let mapViewController = view as? UIViewController else { fatalError("Invalid UI Type") }
        
        mapViewController.navigationController?.navigationBar.prefersLargeTitles = true
        mapViewController.navigationItem.title = "Places of Memories"
        
        return factory(mapViewController)
    }
}
