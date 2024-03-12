//
//  AddAlbumViewController.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 2/12/24.
//

import UIKit

class AddAlbumViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpNavMenu()
        self.setUpContent()
    }
    
    
    // TODO: refactor setup to createModule
    
    private func setUpNavMenu() {
        self.navigationItem.title = "Add New Album"
        let closeButton = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(closeModal))
        self.navigationItem.leftBarButtonItem = closeButton
    }
    
    private func setUpContent() {
        
        let addPlaceholder = UIView()
        addPlaceholder.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(addPlaceholder)
        
        let addAlbumTableView = AddAlbumTableViewController()
        addPlaceholder.addSubview(addAlbumTableView.tableView)
        self.addChild(addAlbumTableView)
        addAlbumTableView.didMove(toParent: self)
        
        // MARK: Auto Layout
        NSLayoutConstraint.activate([
            addAlbumTableView.tableView.topAnchor.constraint(equalTo: view.topAnchor),
            addAlbumTableView.tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            addAlbumTableView.tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            addAlbumTableView.tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 250)
        ])
        
    }
    
    @objc func closeModal() {
        self.dismiss(animated: true)
    }
    
}
