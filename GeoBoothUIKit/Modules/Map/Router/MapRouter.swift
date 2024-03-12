//
//  MapRouter.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 3/13/24.
//

import Foundation
import UIKit

class MapRouter {
    static func build(usingNavigationFactory factory: NavigationFactory) -> UIViewController {
        let view = MapViewController()
        view.navigationController?.navigationBar.prefersLargeTitles = true
        view.navigationItem.title = "Places of Memories"
        let router = MapRouter()
        
        return factory(view)
    }
}
