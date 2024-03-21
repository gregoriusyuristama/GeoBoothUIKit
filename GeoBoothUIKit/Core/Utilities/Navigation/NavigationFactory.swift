//
//  NavigationFactory.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 3/13/24.
//

import Foundation
import UIKit

typealias NavigationFactory = (UIViewController, EnumView) -> (UINavigationController)

class NavigationBuilder {
    static func build(rootView: UIViewController, type: EnumView) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: rootView)
        navigationController.navigationBar.prefersLargeTitles = true
//        let appearance = UINavigationBarAppearance()
//        appearance.configureWithOpaqueBackground()
//        navigationController.navigationBar.scrollEdgeAppearance = appearance
        
        if type == .collection {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithDefaultBackground()
            UINavigationBar.appearance().standardAppearance = navBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance

            if #available(iOS 15.0, *) {
                let tabBarAppearance = UITabBarAppearance()
                tabBarAppearance.configureWithDefaultBackground()
                UITabBar.appearance().standardAppearance = tabBarAppearance
                UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
            }
        }
        
        return navigationController
    }
}
