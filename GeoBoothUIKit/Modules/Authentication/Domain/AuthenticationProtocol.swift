//
//  AuthenticationProtocol.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 3/13/24.
//

import Foundation
import UIKit

protocol AuthenticationRouterProtocol {
    var entry: UIViewController? { get set }
    
    static func start(usingNavigationFactory factory: NavigationFactory) -> UIViewController
    
    func presentHomeView(from view: AuthenticationViewProtocol)
}

protocol AuthenticationManagerProtocol {
    
}

protocol AuthenticationInteractorProtocol {
    var presenter: AuthenticationPresenterProtocol? { get set }
}

protocol AuthenticationViewProtocol {
    var presenter: AuthenticationPresenterProtocol? { get set }
    
}

protocol AuthenticationPresenterProtocol {
    var router: AuthenticationRouterProtocol? { get set }
    var interactor: AuthenticationInteractorProtocol? { get set }
    var view: AuthenticationViewProtocol? { get set }
    
    func signIn()
}
