//
//  SettingPresenter.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 3/31/24.
//

import Foundation

class SettingPresenter: SettingPresenterProtocol {
    var router: (any SettingRouterProtocol)?
    
    var interactor: (any SettingInteractorProtocol)?
    
    var view: (any SettingViewProtocol)?
    
    var isLoading: Bool = false {
        didSet {
            if isLoading {
                view?.updateViewIsLoading()
            } else {
                view?.updateViewIsNotLoading()
            }
        }
    }
    
    func doLogout() {
        isLoading = true
        interactor?.doLogout()
    }
    
    func logoutSuccess() {
        isLoading = false
        view?.updateViewLogoutSuccess()
    }
    
    func logoutFailed(errorMessage: String) {
        isLoading = false
        view?.updateViewLogoutFailed(errorMessage: errorMessage)
    }
    
    func logoutSuccessPopToAuth() {
        guard let view = view else { fatalError("Empty View on Presenter") }
        router?.popToAuthView(from: view)
    }
}
