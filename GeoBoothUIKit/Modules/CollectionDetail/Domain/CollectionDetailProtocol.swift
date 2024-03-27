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
    
    func showCameraView(from view: CollectionDetailViewProtocol, album: AlbumViewModel)
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
    
    func getRegion()
    
    func stopMonitoringRegion()
}

protocol CollectionDetailViewProtocol {
    var presenter: CollectionDetailPresenterProtocol? { get set }
    
    func updateViewSuccess(newAlbumName: String)
    func updateViewFailed(errorMessage: String)
    
    func updateViewDeleteSuccess()
    
    func updateViewIsLoading()
    func updateViewIsNotLoading()
    
    func displayPhotos(photos: [PhotoViewModel])
    
    func updateCameraInRegion()
    func updateCameraOutRegion()
}

protocol CollectionDetailPresenterProtocol {
    var router: CollectionDetailRouterProtocol? { get set }
    var interactor: CollectionDetailInteractorProtocol? { get set }
    var view: CollectionDetailViewProtocol? { get set }
    var isLoading: Bool { get set }
    var isInRegion: Bool { get set }
    
    func interactorDidFetchPhotos(with photos: [PhotoViewModel])
    
    func viewWillDissappear()
    
    func editAlbum(newAlbumName: String)
    func deleteAlbum()
    
    func updateViewSuccess(newAlbumName: String)
    func updateViewFailed(errorMessage: String)
    
    func updateViewDeleteSuccess()
    
    func presentCameraView()
}
