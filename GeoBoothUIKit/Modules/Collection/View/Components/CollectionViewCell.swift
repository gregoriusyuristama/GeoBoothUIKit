//
//  CollectionViewCell.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 3/20/24.
//

import Kingfisher
import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet var collectionImageView: UIImageView!
    @IBOutlet var albumNameLabel: UILabel!
    @IBOutlet var photoCountLabel: UILabel!
    static let identifier = "CollectionViewCell"

    static func nib() -> UINib {
        .init(nibName: identifier, bundle: nil)
    }

    func config(album: AlbumViewModel) {
        albumNameLabel.text = album.albumName

        photoCountLabel.textColor = .systemGray2
        photoCountLabel.text = "\(album.photos.count)"
        
        collectionImageView.contentMode = .scaleAspectFill
        
        if let lastImage = album.photos.last, let imageUrl = URL(string: lastImage.photoUrl) {
            collectionImageView.layer.cornerRadius = 16
            collectionImageView.kf.setImage(with: imageUrl)
        } else {
            collectionImageView.image = UIImage(systemName: "photo.fill")
            
        }
        
    }
}
