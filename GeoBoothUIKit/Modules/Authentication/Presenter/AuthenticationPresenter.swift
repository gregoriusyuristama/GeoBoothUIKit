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
    
    func signIn() {
        guard let view = view else { return }
        router?.presentHomeView(from: view)
    }
}
