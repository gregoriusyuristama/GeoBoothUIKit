//
//  AddAlbumTableViewController.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 2/13/24.
//

import UIKit

class AddAlbumTableViewController: UITableViewController {
    
    var albumNameTextField: UITextField!
    var addAlbumButton: UIButton!
    var addAction: ( (_ albumName: String) -> Void )!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTable()
        self.view.backgroundColor = .systemGray6
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AddAlbumTextFieldTableViewCell.identifier,
                                                           for: indexPath) as? AddAlbumTextFieldTableViewCell else { return UITableViewCell() }
            self.albumNameTextField = cell.addAlbumTextField
            
            cell.roundCorners([.topLeft, .topRight], radius: 16)
            
            return cell
        } else if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MapViewTableViewCell.identifier,
                                                           for: indexPath) as? MapViewTableViewCell else { return UITableViewCell() }
            
            return cell
        } else if indexPath.row == 2 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AddAlbumButtonTableViewCell.identifier,
                                                           for: indexPath) as? AddAlbumButtonTableViewCell else { return UITableViewCell() }
            self.addAlbumButton = cell.addNewAlbumButton
            self.addAlbumButton.addTarget(self, action: #selector(doAddAlbum), for: .touchUpInside)
            cell.roundCorners([.bottomLeft, .bottomRight], radius: 16)
            return cell
        }
        
        return UITableViewCell()
    }
    
    func setUpTable() {
        tableView.register(AddAlbumTextFieldTableViewCell.nib(), forCellReuseIdentifier: AddAlbumTextFieldTableViewCell.identifier)
        tableView.register(MapViewTableViewCell.nib(), forCellReuseIdentifier: MapViewTableViewCell.identifier)
        tableView.register(AddAlbumButtonTableViewCell.nib(), forCellReuseIdentifier: AddAlbumButtonTableViewCell.identifier)
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1 {
            return 300
        }
        return 50
    }
    
    @objc func doAddAlbum() {
        guard let albumName = self.albumNameTextField.text else { return }
        self.addAction(albumName)
    }
}
