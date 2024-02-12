//
//  AddAlbumViewController.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 2/12/24.
//

import UIKit

class AddAlbumViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.isOpaque = true
        self.view.clearsContextBeforeDrawing = true
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false  
        
        self.view.addSubview(label)
        // MARK: Auto Layout
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: safeArea.topAnchor),
            label.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
        label.text = "Hello, world"
        label.textAlignment = .center
    }

}
