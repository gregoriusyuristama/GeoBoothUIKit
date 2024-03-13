//
//  CollectionProtocol.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 3/14/24.
//

import Foundation
import UIKit

protocol CollectionRouterProtocol {
    
    static func build(usingNavigationFactory factory: NavigationFactory) -> UIViewController
}

protocol CollectionManagerProtocol {
    
}

protocol CollectionInteratorProtocol {
    var presenter: CollectionPresenterProtocol? { get set }
}

protocol CollectionViewProtocol {
    var presenter: CollectionPresenterProtocol? { get set }
}

protocol CollectionPresenterProtocol {
    var router: CollectionRouterProtocol? { get set }
    var interactor: CollectionInteratorProtocol? { get set }
    var view: CollectionViewProtocol? { get set }
}
