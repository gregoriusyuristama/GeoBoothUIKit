//
//  AddAlbumViewController.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 2/12/24.
//

import SnapKit
import UIKit

class AddAlbumViewController: UIViewController, AddCollectionViewProtocol {
    var dismissalDelegate: (any CollectionViewModalDismissalDelegate)?
    var presenter: (any AddCollectionPresenterProtocol)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpNavMenu()
        self.setUpContent()
    }
    
    private func setUpNavMenu() {
        let closeButton = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(self.closeModal))
        self.navigationItem.leftBarButtonItem = closeButton
    }
    
    private var spinner = LoadingViewController()
    
    private func setUpContent() {
        let addPlaceholder = UIView()
        self.view.addSubview(addPlaceholder)
        addPlaceholder.snp.makeConstraints { [weak self] make in
            guard let self = self else { return }
            make.center.equalToSuperview()
            make.height.width.equalToSuperview()
        }
        
        let addAlbumTableView = AddAlbumTableViewController()
        addAlbumTableView.addAction = self.addAction
        addPlaceholder.addSubview(addAlbumTableView.tableView)
        self.addChild(addAlbumTableView)
        addAlbumTableView.didMove(toParent: self)
        
        addAlbumTableView.tableView.snp.updateConstraints { [weak self] make in
            guard let self = self else { return }
            make.width.equalToSuperview().inset(16)
            make.height.equalToSuperview()
            make.center.equalToSuperview()
        }
        addPlaceholder.backgroundColor = addAlbumTableView.view.backgroundColor
    }
    
    @objc func closeModal() {
        self.dismiss(animated: true)
    }
    
    @objc func addAction(albumName: String) {
        self.presenter?.addAlbum(albumName: albumName)
    }
    
    func updateViewAddSuccess() {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: "Success", message: "Successfully added new Album", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                self?.dismiss(animated: true)
                self?.dismissalDelegate?.modalDismissed()
            }))
            self?.present(alert, animated: true, completion: nil)
        }
    }
    
    func updateViewAddFailed(errorMessage: String) {
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
}
