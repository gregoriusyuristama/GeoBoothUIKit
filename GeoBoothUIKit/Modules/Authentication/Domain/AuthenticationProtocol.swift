//
//  AuthenticationProtocol.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 3/13/24.
//

import Foundation
import UIKit
import Auth

protocol AuthenticationRouterProtocol {
    var entry: UIViewController? { get set }
    
    static func start(usingNavigationFactory factory: NavigationFactory) -> UIViewController
    
    func presentHomeView(from view: AuthenticationViewProtocol)
}

protocol AuthenticationManagerProtocol {
    
}

protocol AuthenticationInteractorProtocol {
    var presenter: AuthenticationPresenterProtocol? { get set }
    
    func doAuth(email: String, password: String, completion: @escaping (User?, Error?) -> Void)
    func doSignUp(email: String, password: String, completion: @escaping (Void?, Error?) -> Void)
}

protocol AuthenticationViewProtocol {
    var presenter: AuthenticationPresenterProtocol? { get set }
    
    func updateViewIsLoading()
    func updateViewIsNotLoading()
    func updateViewWithError(errorMessage: String)
    func updateViewSignUpSuccess()
}

protocol AuthenticationPresenterProtocol {
    var router: AuthenticationRouterProtocol? { get set }
    var interactor: AuthenticationInteractorProtocol? { get set }
    var view: AuthenticationViewProtocol? { get set }
    
    var isLoading: Bool { get set }
    
    func viewWillAppear()
    
    func signInWithEmailPassword(email: String, password: String)
    func signUpWithEmailPassword(email: String, password: String)
}
