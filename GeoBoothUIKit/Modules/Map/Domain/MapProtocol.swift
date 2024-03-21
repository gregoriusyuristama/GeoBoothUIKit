//
//  MapProtocol.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 3/13/24.
//

import Foundation
import UIKit

protocol MapRouterProtocol {
    static func build(usingNavigationFactory factory: NavigationFactory) -> UIViewController
}

protocol MapManagerProtocol {}

protocol MapInteractorProtocol {
    var presenter: MapPresenterProtocol? { get set }
}

protocol MapViewProtocol {
    var presenter: MapPresenterProtocol? { get set }
}

protocol MapPresenterProtocol {
    var router: MapRouterProtocol? { get set }
    var interactor: MapInteractorProtocol? { get set }
    var view: MapViewProtocol? { get set }
}
