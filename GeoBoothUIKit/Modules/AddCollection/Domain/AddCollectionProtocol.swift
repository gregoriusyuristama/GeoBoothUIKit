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
    func addAlbum(albumName: String, completion: @escaping(Result<Void, Error>) -> Void)
}

protocol AddCollectionInteratorProtocol {
    var presenter: AddCollectionPresenterProtocol? { get set }
    var manager: AddCollectionManagerProtocol { get set }
    
    func addAlbum(albumName: String)
}

protocol AddCollectionViewProtocol {
    var presenter: AddCollectionPresenterProtocol? { get set }
    
    func updateViewAddSuccess()
    func updateViewAddFailed(errorMessage: String)
    func updateViewIsLoading()
    func updateViewIsNotLoading()
}

protocol AddCollectionPresenterProtocol {
    var router: AddCollectionRouterProtocol? { get set }
    var interactor: AddCollectionInteratorProtocol? { get set }
    var view: AddCollectionViewProtocol? { get set }
    var isLoading: Bool { get set }
    
    func addAlbum(albumName: String)
    func addAlbumSuccess()
    func addAlbumFailed(errorMessage: String)
}
