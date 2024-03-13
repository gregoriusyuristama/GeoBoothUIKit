//
//  ViewController.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 2/7/24.
//

import UIKit

class CollectionViewController: UIViewController, CollectionViewProtocol {
    var presenter: (any CollectionPresenterProtocol)?
    
    /// Label displaying empty prompt when user doesn't have any album
    var contentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        // Do any additional setup after loading the view.
        self.setupNavbarItem()
        self.setupContentLabel()
    }
    
    
    // TODO: refactor setup to createModule
    fileprivate func setupNavbarItem() {
        let plusIcon = UIImage(named: ResourcePath.plusIcon)?.resizeImage(scaledToSize: CGSize(width: 22, height: 22))
        let addButton = UIBarButtonItem(image: plusIcon, style: .plain, target: self, action: #selector(showAddModal))
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    fileprivate func setupContentLabel() {
        contentLabel = UILabel()
        contentLabel.numberOfLines = 0
        let attrString = NSMutableAttributedString(
            string: "\(AppLabel.emptyStateLabel[0])\n",
            attributes: [
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17)
            ]
        )
        attrString.append(NSMutableAttributedString(
            string: AppLabel.emptyStateLabel[1],
            attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17),
                NSAttributedString.Key.foregroundColor: UIColor.gray
            ]
        ))
        // create our NSTextAttachment
        let image1Attachment = NSTextAttachment()
        let plusImage = UIImage(named: ResourcePath.plusIcon)
        let grayPlusImage = plusImage?
            .withColor(UIColor.gray)?
            .resizeImage(
                scaledToSize: CGSize(
                    width: 17,
                    height: 17
                )
            )
        image1Attachment.image = grayPlusImage
        
        let imageToString = NSAttributedString(
            attachment: image1Attachment
        )
        attrString.append(imageToString)
        
        attrString.append(NSMutableAttributedString(
            string: AppLabel.emptyStateLabel[2],
            attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17),
                NSAttributedString.Key.foregroundColor: UIColor.gray
            ]
        ))
        
        self.view.addSubview(contentLabel)
        contentLabel.attributedText = attrString
        contentLabel.textAlignment = .center
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // MARK: Auto Layout
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            contentLabel.topAnchor.constraint(equalTo: safeArea.topAnchor),
            contentLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            contentLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            contentLabel.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
    
    @objc func showAddModal(sender: UIButton!) {
        let addAlbumVC = UINavigationController(rootViewController: AddAlbumViewController())
        self.present(addAlbumVC, animated: true, completion: nil)
    }
}
