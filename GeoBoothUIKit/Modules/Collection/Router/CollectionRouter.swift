//
//  CollectionRouter.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 3/13/24.
//

import Foundation
import UIKit


class CollectionRouter {
    
    static func build(usingNavigationFactory factory: NavigationFactory) -> UIViewController {
        let view = CollectionViewController()
        view.navigationController?.navigationBar.prefersLargeTitles = true
        view.navigationItem.title = "GeoBooth"
        let router = CollectionRouter()
        // TODO: implement interactor, presenter
        
        return factory(view)
    }
}
