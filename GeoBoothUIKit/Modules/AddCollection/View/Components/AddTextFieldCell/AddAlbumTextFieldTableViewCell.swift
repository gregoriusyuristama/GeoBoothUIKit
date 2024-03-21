//
//  AddAlbumTableViewCell.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 2/14/24.
//

import UIKit

class AddAlbumTextFieldTableViewCell: UITableViewCell {
    @IBOutlet weak var addAlbumTextField: UITextField!
    static let identifier = "AddAlbumTextFieldTableViewCell"

    static func nib() -> UINib {
        .init(nibName: identifier, bundle: nil)
    }
    
}
