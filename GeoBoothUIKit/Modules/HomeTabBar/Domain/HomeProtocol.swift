//
//  HomeProtocol.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 3/13/24.
//

import Foundation
import UIKit

typealias EntryPoint = UITabBarController

protocol HomeRouterProtocol {
    
    static func start() -> UITabBarController
}

protocol HomeInteractorProtocol {
    var presenter: HomePresenterProtocol? { get set }
}

protocol HomeViewProtocol {
    var presenter: HomePresenterProtocol? { get set }
}

protocol HomeManagerProtocol {
    
}

protocol HomePresenterProtocol {
    var router: HomeRouterProtocol? { get set }
    var interactor: HomeInteractorProtocol? { get set }
    var view: HomeViewProtocol? { get set }
    
}
