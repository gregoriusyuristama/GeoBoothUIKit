//
//  CollectionPresenter.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 3/14/24.
//

import Foundation

class CollectionPresenter: CollectionPresenterProtocol {
    var router: (any CollectionRouterProtocol)?
    
    var interactor: (any CollectionInteratorProtocol)?
    
    var view: (any CollectionViewProtocol)?
    
    
}
