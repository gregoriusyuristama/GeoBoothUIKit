//
//  CollectionViewCell.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 3/20/24.
//

import UIKit
import Kingfisher

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var collectionImageView: UIImageView!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var photoCountLabel: UILabel!
    static let identifier = "CollectionViewCell"
    
    static func nib() -> UINib {
        .init(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func config(album: AlbumViewModel, photos: [PhotoViewModel]?) {
        self.albumNameLabel.text = album.albumName
        if let photos = photos {
            photoCountLabel.text = photos.count.description
            if let imageUrl = URL(string: photos.first?.photoUrl ?? "") {
                collectionImageView.kf.setImage(with: imageUrl)
            }
        } else {
            photoCountLabel.text = "0"
            collectionImageView.image = UIImage(systemName: "photo.fill")
        }
    }

}
