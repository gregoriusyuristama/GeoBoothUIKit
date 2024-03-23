//
//  CollectionDetailProtocol.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 3/23/24.
//

import Foundation
import UIKit

protocol CollectionDetailRouterProtocol {
    static func build(album: AlbumViewModel) -> UIViewController
}

protocol CollectionDetailManagerProtocol {
    func editAlbum(album: UpdateAlbumDTO, completion: @escaping((Result<Void, Error>) -> Void))
    func deleteAlbum(album: AlbumViewModel, completion: @escaping((Result<Void, Error>) -> Void))
}

protocol CollectionDetailInteractorProtocol {
    var presenter: CollectionDetailPresenterProtocol? { get set }
    var manager: CollectionDetailManagerProtocol? { get set }
    
    var album: AlbumViewModel? { get set }
    
    func getPhotos()
    
    func editAlbum(newAlbumName: String)
    func deleteAlbum()
}

protocol CollectionDetailViewProtocol {
    var presenter: CollectionDetailPresenterProtocol? { get set }
    
    func updateViewSuccess(newAlbumName: String)
    func updateViewFailed(errorMessage: String)
    
    func updateViewDeleteSuccess()
    
    func updateViewIsLoading()
    func updateViewIsNotLoading()
    
    func displayPhotos(photos: [PhotoViewModel])
}

protocol CollectionDetailPresenterProtocol {
    var router: CollectionDetailRouterProtocol? { get set }
    var interactor: CollectionDetailInteractorProtocol? { get set }
    var view: CollectionDetailViewProtocol? { get set }
    var isLoading: Bool { get set }
    
    func interactorDidFetchPhotos(with photos: [PhotoViewModel])
    
    func editAlbum(newAlbumName: String)
    func deleteAlbum()
    
    func updateViewSuccess(newAlbumName: String)
    func updateViewFailed(errorMessage: String)
    
    func updateViewDeleteSuccess()
}
