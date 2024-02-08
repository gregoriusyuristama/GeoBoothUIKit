//
//  ViewController.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 2/7/24.
//

import UIKit

class CollectionViewController: UIViewController {
    
    var contentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupNavbarItem()
        self.setupContentLabel()
    }
    
    fileprivate func setupNavbarItem() {
        let plusIcon = UIImage(named: ResourcePath.plusIcon)?.resizeImage(scaledToSize: CGSize(width: 22, height: 22))
        let addButton = UIBarButtonItem(image: plusIcon, style: .plain, target: self, action: nil)
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
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            contentLabel.topAnchor.constraint(equalTo: safeArea.topAnchor),
            contentLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            contentLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            contentLabel.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
    
}
