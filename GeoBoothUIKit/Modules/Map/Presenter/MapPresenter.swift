//
//  MapPresenter.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 3/21/24.
//

import Foundation

class MapPresenter: MapPresenterProtocol {
    var router: (any MapRouterProtocol)?
    
    var interactor: (any MapInteractorProtocol)?
    
    var view: (any MapViewProtocol)?
}
