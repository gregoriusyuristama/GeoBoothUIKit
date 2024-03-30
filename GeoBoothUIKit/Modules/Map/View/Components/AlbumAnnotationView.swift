//
//  AlbumAnnotationView.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 3/31/24.
//

import Kingfisher
import MapKit
import UIKit

class AlbumAnnotationView: MKAnnotationView {
    var imageUrl: String?
    
    static let identifier = "AlbumAnnotationView"
    
    private lazy var containerView: UIView = {
        let view = UIView(frame: CGRect(x: -40, y: -80, width: 80, height: 80))
        view.backgroundColor = .white
        view.layer.cornerRadius = 16.0
        return view
    }()
    
    private var imageView: UIImageView!
    
    private lazy var bottomCornerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 4.0
        return view
    }()
    
    // MARK: Initialization

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    convenience init(annotation: MKAnnotation?, reuseIdentifier: String?, imageUrl: String?) {
        self.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.imageUrl = imageUrl
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        containerView.addSubview(bottomCornerView)
        bottomCornerView.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -15.0).isActive = true
        bottomCornerView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        bottomCornerView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        bottomCornerView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        let angle = (39.0 * CGFloat.pi) / 180
        let transform = CGAffineTransform(rotationAngle: angle)
        bottomCornerView.transform = transform
        
        addSubview(containerView)
        
        imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        if let imageUrl = imageUrl {
            imageView.kf.setImage(with: URL(string: imageUrl))
        } else {
            imageView.image = UIImage(systemName: "photo")
        }
        imageView.layer.cornerRadius = 8.0
        imageView.clipsToBounds = true
        
        containerView.addSubview(imageView)
        imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8.0).isActive = true
        imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8.0).isActive = true
        imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8.0).isActive = true
        imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8.0).isActive = true
    }
}
