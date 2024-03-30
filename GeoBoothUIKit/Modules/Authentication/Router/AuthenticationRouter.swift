//
//  AuthenticationRouter.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 3/13/24.
//

import Foundation
import UIKit

class AuthenticationRouter: AuthenticationRouterProtocol {
    var entry: UIViewController?
    
    static func start(usingNavigationFactory factory: NavigationFactory) -> UIViewController {
        let router = AuthenticationRouter()
        
        var view: AuthenticationViewProtocol = AuthenticationViewController()
        var presenter: AuthenticationPresenterProtocol = AuthenticationPresenter()
        var interactor: AuthenticationInteractorProtocol = AuthenticationInteractor()
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        guard let viewEntry = view as? UIViewController else { fatalError("Invalid UI Type") }
        
        router.entry = viewEntry
        
        return factory(viewEntry, .authentication)
    }
    
    func presentHomeView(from view: any AuthenticationViewProtocol) {
        let submodules = (
            collection: CollectionRouter.build(usingNavigationFactory: NavigationBuilder.build(rootView:type:)),
            map: MapRouter.build(usingNavigationFactory: NavigationBuilder.build(rootView:type:)),
            setting: SettingRouter.build(usingNavigationFactory: NavigationBuilder.build(rootView:type:))
        )
        let homeViewController = HomeRouter.createModule(usingSubmodules: submodules)
        
        guard let viewController = view as? UIViewController else { fatalError("Invalid View Controller Type") }
        viewController.view.window?.rootViewController = homeViewController
        
    }

}
