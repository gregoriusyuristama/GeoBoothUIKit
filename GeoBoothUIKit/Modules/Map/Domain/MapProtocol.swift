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

protocol MapManagerProtocol {
    func getRemoteMapLocations(completion: @escaping (Result<[AlbumDTO], Error>) -> Void)
}

protocol MapInteractorProtocol {
    var presenter: MapPresenterProtocol? { get set }
    var manager: MapManagerProtocol? { get set }

    func getMapLocations()
}

protocol MapViewProtocol {
    var presenter: MapPresenterProtocol? { get set }

    func update(with albums: [AlbumViewModel])
    func update(with error: String)
    func updateViewIsLoading()
    func updateViewIsNotLoading()
}

protocol MapPresenterProtocol {
    var router: MapRouterProtocol? { get set }
    var interactor: MapInteractorProtocol? { get set }
    var view: MapViewProtocol? { get set }
    
    var isLoading: Bool { get set }

    func interactorDidFetchMapLocations(with result: Result<[AlbumViewModel], Error>)
}
