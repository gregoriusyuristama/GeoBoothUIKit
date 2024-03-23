//
//  CollectionDetailViewController.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 3/23/24.
//

import Foundation
import UIKit

class CollectionDetailViewController: UIViewController, CollectionDetailViewProtocol {
    var presenter: (any CollectionDetailPresenterProtocol)?
    
    private var spinner = LoadingViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupNavbarItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.largeTitleDisplayMode = .never
    }
    
    fileprivate func setupNavbarItem() {
        let cameraButton = UIBarButtonItem(image: UIImage(systemName: "camera"), style: .plain, target: self, action: #selector(takePhoto))
        
        if #available(iOS 14.0, *) {
            let renameItem = UIAction(
                title: "Rename Album",
                image: UIImage(systemName: "pencil")
            ) { _ in
                self.editAlbum()
            }
            
            let deleteItem = UIAction(
                title: "Delete Album",
                image: UIImage(systemName: "trash"),
                attributes: .destructive
            ) { _ in
                self.deleteAlbum()
            }
            
            let menu = UIMenu(
                children: [
                    renameItem,
                    deleteItem
                ]
            )
            
            let moreButton = UIBarButtonItem(
                image: UIImage(systemName: "ellipsis.circle"),
                primaryAction: nil,
                menu: menu
            )
            navigationItem.rightBarButtonItems = [
                moreButton,
                cameraButton
            ]
        } else {
            let deleteButton = UIBarButtonItem(
                image: UIImage(systemName: "trash")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal),
                style: .plain,
                target: self,
                action: #selector(deleteAlbum)
            )
            
            let editButton = UIBarButtonItem(
                image: UIImage(systemName: "pencil"),
                style: .plain,
                target: self,
                action: #selector(editAlbum)
            )
            navigationItem.rightBarButtonItems = [
                deleteButton,
                editButton,
                cameraButton
            ]
        }
    }
    
    func updateViewSuccess(newAlbumName: String) {
        DispatchQueue.main.async { [weak self] in
            self?.navigationItem.title = newAlbumName
            let alert = UIAlertController(title: "Success", message: "Successfully update album name", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self?.present(alert, animated: true, completion: nil)
        }
    }
    
    func updateViewFailed(errorMessage: String) {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self?.present(alert, animated: true, completion: nil)
        }
    }
    
    func updateViewIsLoading() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.addChild(self.spinner)
            self.spinner.view.frame = self.view.frame
            self.view.addSubview(self.spinner.view)
            self.spinner.didMove(toParent: self)
        }
    }
    
    func updateViewIsNotLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.spinner.willMove(toParent: nil)
            self?.spinner.view.removeFromSuperview()
            self?.spinner.removeFromParent()
        }
    }
    
    func updateViewDeleteSuccess() {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: "Success", message: "Successfully delete album", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                self?.navigationController?.popViewController(animated: true)
            }))
            self?.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc private func takePhoto() {}
    
    @objc private func deleteAlbum() {
        let alertControlller = UIAlertController(title: "Are you sure do you want delete this album", message: nil, preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [unowned alertControlller] _ in
            self.presenter?.deleteAlbum()
            alertControlller.dismiss(animated: true)
        }
        
        alertControlller.addAction(deleteAction)
        present(alertControlller, animated: true)
    }
    
    @objc private func editAlbum() {
        let alertControlller = UIAlertController(title: "New Album name", message: nil, preferredStyle: .alert)
        alertControlller.addTextField()
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned alertControlller] _ in
            if let newAlbumName = alertControlller.textFields?[0].text {
                if !newAlbumName.isEmpty {
                    self.presenter?.editAlbum(newAlbumName: newAlbumName)
                }
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { [unowned alertControlller] _ in
            alertControlller.dismiss(animated: true)
        }
        
        alertControlller.addAction(submitAction)
        alertControlller.addAction(cancelAction)
        
        present(alertControlller, animated: true)
    }
}
