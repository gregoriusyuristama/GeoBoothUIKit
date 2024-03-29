//
//  ViewController.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 2/7/24.
//

import SnapKit
import UIKit

class CollectionViewController: UIViewController, CollectionViewProtocol, CollectionViewModalDismissalDelegate {
    var presenter: (any CollectionPresenterProtocol)?
    
    private var albums: [AlbumViewModel] = []
    
    private var spinner = LoadingViewController()
    
    /// Label displaying empty prompt when user doesn't have any album
    private var contentLabel: UILabel = {
        let contentLabel = UILabel()
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
        
        contentLabel.attributedText = attrString
        contentLabel.textAlignment = .center
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        return contentLabel
    }()
    
    var contentView: UIView!
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CollectionViewCell.nib(), forCellWithReuseIdentifier: CollectionViewCell.identifier)
        collectionView.isHidden = true
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        setupNavbarItem()
        setupContentView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.largeTitleDisplayMode = .automatic
        title = "GeoBooth"
        presenter?.triggerFetchAlbum()
    }
    
    fileprivate func setupNavbarItem() {
        let plusIcon = UIImage(named: ResourcePath.plusIcon)?.resizeImage(scaledToSize: CGSize(width: 22, height: 22))
        let addButton = UIBarButtonItem(image: plusIcon, style: .plain, target: self, action: #selector(showAddModal))
        navigationItem.rightBarButtonItem = addButton
    }
    
    fileprivate func setupContentView() {
        contentView = UIView()
        view.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.width.height.equalToSuperview()
        }
        setupContentLabel()
        setupCollectionView()
    }
    
    fileprivate func setupContentLabel() {
        contentView.addSubview(contentLabel)
        
        contentLabel.snp.makeConstraints { make in
            make.width.height.equalToSuperview()
        }
    }
    
    fileprivate func setupCollectionView() {
        contentView.addSubview(collectionView)
        collectionView.snp.updateConstraints { make in
            make.width.height.equalToSuperview()
        }
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func update(with albums: [AlbumViewModel]) {
        DispatchQueue.main.async { [weak self] in
            self?.albums = albums
            self?.collectionView.reloadData()
            if albums.isEmpty {
                self?.contentLabel.isHidden = false
                self?.collectionView.isHidden = true
            } else {
                self?.contentLabel.isHidden = true
                self?.collectionView.isHidden = false
            }
        }
    }
    
    func update(with error: String) {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self?.present(alert, animated: true, completion: nil)
        }
    }
    
    func updateViewIsLoading() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.addChild(self.spinner)
            self.spinner.view.frame = self.view.frame
            self.view.addSubview(self.spinner.view)
            self.spinner.didMove(toParent: self)
        }
    }
    
    func updateViewIsNotLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.spinner.willMove(toParent: nil)
            self?.spinner.view.removeFromSuperview()
            self?.spinner.removeFromParent()
        }
    }
    
    @objc func showAddModal(sender: UIButton!) {
        presenter?.showAddAlbumModal()
    }
}

extension CollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        albums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as? CollectionViewCell
        else { return UICollectionViewCell() }
        cell.config(album: albums[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.showAlbumDetail(album: albums[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 2
        return CGSize(width: width, height: width + 24)
    }
    
    func modalDismissed() {
        presenter?.triggerFetchAlbum()
    }
}
