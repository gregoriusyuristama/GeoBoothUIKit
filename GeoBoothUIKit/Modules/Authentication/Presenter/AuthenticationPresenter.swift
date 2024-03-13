//
//  AuthenticationPresenter.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 3/13/24.
//

import Foundation

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
            if let user = user {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.isLoading = false
                    self.router?.presentHomeView(from: view)
                }
            } else {
                guard let errorMessage = error?.localizedDescription else { return }
                DispatchQueue.main.async { [weak self] in
                    self?.isLoading = false
                    self?.view?.updateViewWithError(errorMessage: errorMessage)
                }
                
            }
            
        }
        
    }
}
