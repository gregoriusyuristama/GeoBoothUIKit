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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTable()
        if #available(iOS 13.0, *) {
            self.view.backgroundColor = .systemGray6
        } else {
            // TODO: Fallback on earlier versions
        }
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
            return cell
        }

        // Configure the cell...

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
        // TODO: Add save functionality to CoreData
        print(self.albumNameTextField.text)
        print(LocationServices.shared.locationManager.location)
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
