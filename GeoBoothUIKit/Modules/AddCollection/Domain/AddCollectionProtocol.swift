//
//  AddCollectionProtocol.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 3/19/24.
//

import Foundation
import UIKit

protocol AddCollectionRouterProtocol {
    static func build(usingNavigationFactory factory: NavigationFactory) -> UIViewController
}

protocol AddCollectionManagerProtocol {
    
}

protocol AddCollectionInteratorProtocol {
    var presenter: AddCollectionPresenterProtocol? { get set }
}

protocol AddCollectionViewProtocol {
    var presenter: AddCollectionPresenterProtocol? { get set }
}

protocol AddCollectionPresenterProtocol {
    var router: AddCollectionRouterProtocol? { get set }
    var interactor: AddCollectionInteratorProtocol? { get set }
    var view: AddCollectionViewProtocol? { get set }
}
