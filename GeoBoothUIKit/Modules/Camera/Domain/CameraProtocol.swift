//
//  CameraProtocol.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 3/25/24.
//

import Foundation
import UIKit

protocol CameraRouterProtocol {
    static func build() -> UIViewController
}

protocol CameraManagerProtocol {
    func savePhoto(imageData: Data, completion: @escaping (Result<Void, Error>) -> Void)
}

protocol CameraInteractorProtocol {
    var presenter: CameraPresenterProtocol? { get set }
    var manager: CameraManagerProtocol? { get set }
    
    func savePhoto(imageData: Data)
}

protocol CameraViewProtocol {
    var presenter: CameraPresenterProtocol? { get set }
}

protocol CameraPresenterProtocol {
    var router: CameraRouterProtocol? { get set }
    var interactor: CameraInteractorProtocol? { get set }
    var view: CameraViewProtocol? { get set }
    
    func doSavePhoto(imageData: Data)
}
