//
//  TabController.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 2/7/24.
//

import UIKit

typealias HomeTabs = (
    collection: UIViewController,
    map: UIViewController
)

class HomeTabBarController: UITabBarController, HomeViewProtocol {
    var presenter: (any HomePresenterProtocol)?
    
    init(tabs: HomeTabs) {
        super.init(nibName: nil, bundle: nil)
        viewControllers = [tabs.collection, tabs.map]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        let resizedImage = image?.resizeImage(scaledToSize: CGSize(width: 22, height: 22))
        nav.tabBarItem.image = resizedImage
        nav.navigationBar.prefersLargeTitles = true
        
        nav.viewControllers.first?.navigationItem.title = navTitle
        
        return nav
    }
    
}
