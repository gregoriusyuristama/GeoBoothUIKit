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
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func nib() -> UINib {
        .init(nibName: identifier, bundle: nil)
    }
    
}
