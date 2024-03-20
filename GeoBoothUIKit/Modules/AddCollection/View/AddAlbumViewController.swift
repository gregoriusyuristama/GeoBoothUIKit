//
//  AddAlbumViewController.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 2/12/24.
//

import UIKit
import SnapKit

class AddAlbumViewController: UIViewController, AddCollectionViewProtocol {
    var presenter: (any AddCollectionPresenterProtocol)?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpNavMenu()
        self.setUpContent()
    }
    
    private func setUpNavMenu() {
        let closeButton = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(closeModal))
        self.navigationItem.leftBarButtonItem = closeButton
    }
    
    private func setUpContent() {
        
        let addPlaceholder = UIView()
        self.view.addSubview(addPlaceholder)
        addPlaceholder.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalToSuperview()
        }
        
        let addAlbumTableView = AddAlbumTableViewController()
        addPlaceholder.addSubview(addAlbumTableView.tableView)
        self.addChild(addAlbumTableView)
        addAlbumTableView.didMove(toParent: self)
        
        addAlbumTableView.tableView.snp.updateConstraints { make in
            make.width.equalToSuperview().inset(16)
            make.height.equalToSuperview()
            make.center.equalToSuperview()
        }
        addPlaceholder.backgroundColor = addAlbumTableView.view.backgroundColor
        
    }
    
    @objc func closeModal() {
        self.dismiss(animated: true)
    }
    
}
