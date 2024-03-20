//
//  AuthenticationPresenter.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 3/13/24.
//

import Foundation
import KeychainSwift

class AuthenticationPresenter: AuthenticationPresenterProtocol {
    
    var router: (any AuthenticationRouterProtocol)?
    var view: (any AuthenticationViewProtocol)?
    var interactor: (any AuthenticationInteractorProtocol)?
    
    var isLoading: Bool = false {
        didSet {
            if isLoading {
                view?.updateViewIsLoading()
            } else {
                view?.updateViewIsNotLoading()
            }
        }
    }
    
    func signInWithEmailPassword(email: String, password: String) {
        guard let view = view else { return }
        isLoading = true
        interactor?.doAuth(email: email, password: password) { user, error in
            if let errorMessage = error?.localizedDescription {
                DispatchQueue.main.async { [weak self] in
                    self?.isLoading = false
                    self?.view?.updateViewWithError(errorMessage: errorMessage)
                }
            } else  {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.isLoading = false
                    self.router?.presentHomeView(from: view)
                }
            }
            
        }
        
    }
    
    func viewWillAppear() {
        let keychain = KeychainSwift()
        guard let view = view, let email = keychain.get(KeychainKeyConstant.email), let password = keychain.get(KeychainKeyConstant.password) else { return }
        
        self.signInWithEmailPassword(email: email, password: password)
        
    }
    
}
