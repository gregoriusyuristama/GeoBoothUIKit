//
//  SettingProtocol.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 3/31/24.
//

import Foundation
import UIKit

protocol SettingRouterProtocol {
    static func build(usingNavigationFactory factory: NavigationFactory) -> UIViewController
    
    func popToAuthView(from view: SettingViewProtocol)
}

protocol SettingManagerProtocol {
    func logout(completion: @escaping (Result<Void, Error>) -> Void)
}

protocol SettingInteractorProtocol {
    var presenter: SettingPresenterProtocol? { get set }
    var manager: SettingManagerProtocol? { get set }
    
    func doLogout()
}

protocol SettingViewProtocol {
    var presenter: SettingPresenterProtocol? { get set }
    
    func updateViewIsLoading()
    func updateViewIsNotLoading()
    func updateViewLogoutSuccess()
    func updateViewLogoutFailed(errorMessage: String)
}

protocol SettingPresenterProtocol {
    var router: SettingRouterProtocol? { get set }
    var interactor: SettingInteractorProtocol? { get set }
    var view: SettingViewProtocol? { get set }
    
    var isLoading: Bool { get set }
    
    func logoutSuccess()
    func logoutFailed(errorMessage: String)
    
    func doLogout()
    
    func logoutSuccessPopToAuth()
}
