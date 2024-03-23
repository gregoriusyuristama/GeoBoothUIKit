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

    func presentAddAlbumModal(from view: CollectionViewProtocol)
    func presentAlbumDetail(from view: CollectionViewProtocol, album: AlbumViewModel)
}

protocol CollectionManagerProtocol {
    func getRemoteAlbums(completion: @escaping ((Result<[AlbumDTO], Error>) -> Void))
}

protocol CollectionInteratorProtocol {
    var presenter: CollectionPresenterProtocol? { get set }
    var manager: CollectionManagerProtocol { get set }
    
    func getAlbums()
}

protocol CollectionViewProtocol {
    var presenter: CollectionPresenterProtocol? { get set }
    
    func update(with albums: [AlbumViewModel])
    func update(with error: String)
    func updateViewIsLoading()
    func updateViewIsNotLoading()
}

protocol CollectionPresenterProtocol {
    var router: CollectionRouterProtocol? { get set }
    var interactor: CollectionInteratorProtocol? { get set }
    var view: CollectionViewProtocol? { get set }
    
    var isLoading: Bool { get set }
    
    func interactorDidFetchAlbums(with result: Result<[AlbumViewModel], Error>)
    func showAddAlbumModal()
    func showAlbumDetail(album: AlbumViewModel)
    
    func triggerFetchAlbum()
}

protocol CollectionViewModalDismissalDelegate: AnyObject {
    func modalDismissed()
}
