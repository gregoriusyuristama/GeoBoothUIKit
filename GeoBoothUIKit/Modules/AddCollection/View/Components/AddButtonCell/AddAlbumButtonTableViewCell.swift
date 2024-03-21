//
//  AddAlbumButtonTableViewCell.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 2/14/24.
//

import UIKit

class AddAlbumButtonTableViewCell: UITableViewCell {

    @IBOutlet weak var addNewAlbumButton: UIButton!
    static let identifier = "AddAlbumButtonTableViewCell"

    static func nib() -> UINib {
        .init(nibName: identifier, bundle: nil)
    }
    
    @IBAction func doAddNewAlbum(_ sender: Any) {
        
    }
}
