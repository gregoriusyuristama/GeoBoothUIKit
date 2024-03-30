//
//  SettingInteractor.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 3/31/24.
//

import Foundation

class SettingInteractor: SettingInteractorProtocol {
    var presenter: (any SettingPresenterProtocol)?
    
    var manager: (any SettingManagerProtocol)?
    
    init(manager: (any SettingManagerProtocol)? = nil) {
        self.manager = manager
    }
    
    func doLogout() {
        manager?.logout(completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                self.presenter?.logoutSuccess()
            case .failure(let failure):
                self.presenter?.logoutFailed(errorMessage: failure.localizedDescription)
            }
        })
    }
}
