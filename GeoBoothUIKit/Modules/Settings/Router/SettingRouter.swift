//
//  SettingRouter.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 3/31/24.
//

import Foundation
import UIKit

class SettingRouter: SettingRouterProtocol {
    static func build(usingNavigationFactory factory: NavigationFactory) -> UIViewController {
        let router = SettingRouter()
        
        var view: SettingViewProtocol = SettingViewController()
        var presenter: SettingPresenterProtocol = SettingPresenter()
        let manager: SettingManagerProtocol = SettingManager()
        var interactor: SettingInteractorProtocol = SettingInteractor(manager: manager)
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        guard let viewController = view as? UIViewController else { fatalError("Invalid UI Type") }
        
        viewController.navigationItem.title = "Setting"
        
        return factory(viewController, .setting)
    }

    func popToAuthView(from view: any SettingViewProtocol) {
        let authViewController = AuthenticationRouter.start(usingNavigationFactory: NavigationBuilder.build(rootView:type:))
        
        guard let viewController = view as? UIViewController else { fatalError("Invalid View Controller Type") }
        
        viewController.view.window?.rootViewController = authViewController
    }
    
}
