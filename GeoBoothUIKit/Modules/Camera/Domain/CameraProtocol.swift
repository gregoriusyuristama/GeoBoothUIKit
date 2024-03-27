//
//  CameraProtocol.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 3/25/24.
//

import Foundation
import UIKit

protocol CameraRouterProtocol {
    static func build(album: AlbumViewModel) -> UIViewController
    
    func popViewController(from view: CameraViewProtocol)
}

protocol CameraManagerProtocol {
    func savePhoto(imageData: Data, album: AlbumViewModel, completion: @escaping (Result<Void, Error>) -> Void)
}

protocol CameraInteractorProtocol {
    var presenter: CameraPresenterProtocol? { get set }
    var manager: CameraManagerProtocol? { get set }
    
    var album: AlbumViewModel? { get set }
    
    func savePhoto(imageData: Data)
}

protocol CameraViewProtocol {
    var presenter: CameraPresenterProtocol? { get set }
    
    func updateViewSavePhotoSuccess()
    func updateViewSavePhotoFailed(errorMessage: String)
    func updateViewIsLoading()
    func updateViewIsNotLoading()
}

protocol CameraPresenterProtocol {
    var router: CameraRouterProtocol? { get set }
    var interactor: CameraInteractorProtocol? { get set }
    var view: CameraViewProtocol? { get set }
    
    var isLoading: Bool { get set }
    
    func doSavePhoto(imageData: Data)
    
    func savePhotoSuccess()
    func savePhotoFailed(errorMessage: String)
    
    func popViewController()
}
