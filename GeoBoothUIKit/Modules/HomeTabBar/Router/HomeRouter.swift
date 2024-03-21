//
//  HomeRouter.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 3/12/24.
//

import Foundation
import UIKit

class HomeRouter {
    
    var viewController: UIViewController
    
    typealias Submodules = (
        collection: UIViewController,
        map: UIViewController
    )
    
    init(viewController: UIViewController, submodules: Submodules) {
        self.viewController = viewController
    }
    
    static func createModule(usingSubmodules submodules: HomeRouter.Submodules) -> UITabBarController {
        
        let tabs = HomeRouter.tabs(usingSubmodules: submodules)
        let tabBarController = HomeTabBarController(tabs: tabs)
        
        return tabBarController
    }
    
}

extension HomeRouter {
    static func tabs(usingSubmodules submodules: Submodules) -> HomeTabs {
        let collectionTabBarItem = UITabBarItem(
            title: AppLabel.collectionTabTitle,
            image: UIImage(named: ResourcePath.collectionTabIcon)?.resizeImage(scaledToSize: CGSize(width: 22, height: 22)),
            tag: 1
        )
        let mapTabBarItem = UITabBarItem(
            title: AppLabel.mapTabTitle,
            image: UIImage(named: ResourcePath.mapTabIcon)?.resizeImage(scaledToSize: CGSize(width: 22, height: 22)),
            tag: 2
        )
        
        submodules.collection.tabBarItem = collectionTabBarItem
        submodules.map.tabBarItem = mapTabBarItem
        return (
            collection: submodules.collection,
            map: submodules.map
        )
    }
}
