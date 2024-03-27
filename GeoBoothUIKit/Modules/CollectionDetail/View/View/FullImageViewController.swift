//
//  FullImageViewController.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 3/28/24.
//

import SnapKit
import UIKit

class FullImageViewController: UIViewController {
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.loadImageView()
    }

    private func loadImageView() {
        guard let image = image else { return }
        let imageView = PanImageZoomView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .systemBackground
        imageView.frame = view.bounds
        imageView.isUserInteractionEnabled = true
        view.addSubview(imageView)
    }
}
