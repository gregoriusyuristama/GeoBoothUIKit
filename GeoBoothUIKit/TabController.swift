//
//  TabController.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 2/7/24.
//

import UIKit

class TabController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabs()
        // Do any additional setup after loading the view.
    }
    
    // MARK: Setup Tabs
    private func setupTabs() {
        let collection = self.createNav(
            with: AppLabel.collectionTabTitle,
            and: UIImage(named: ResourcePath.collectionTabIcon),
            navTitle: AppLabel.collectionNavTitle,
            viewController: CollectionViewController()
        )
        
        let map = self.createNav(
            with: AppLabel.mapTabTitle,
            and: UIImage(named: ResourcePath.mapTabIcon),
            navTitle: AppLabel.mapNavTitle,
            viewController: MapViewController()
        )
        
        self.setViewControllers([collection, map], animated: true)
        
    }
    
    private func createNav(with title: String, and image: UIImage?, navTitle: String, viewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: viewController)
        nav.tabBarItem.title = title
        let resizedImage = image?.resizeImage(22, opaque: false)
        nav.tabBarItem.image = resizedImage
        nav.navigationBar.prefersLargeTitles = true
        
        nav.viewControllers.first?.navigationItem.title = navTitle
        
        return nav
    }

}
