//
//  AddCollectionPresenter.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 3/19/24.
//

import Foundation

class AddCollectionPresenter: AddCollectionPresenterProtocol {
    var router: (any AddCollectionRouterProtocol)?
    
    var interactor: (any AddCollectionInteratorProtocol)?
    
    var view: (any AddCollectionViewProtocol)?
    
}
