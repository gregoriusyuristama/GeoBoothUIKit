//
//  CollectionDetailViewController.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 3/23/24.
//

import AVFoundation
import Foundation
import Kingfisher
import SnapKit
import UIKit

class CollectionDetailViewController: UIViewController {
    var presenter: (any CollectionDetailPresenterProtocol)?
    
    private var selectedImage: PhotoViewModel? = nil
    private var spinner = LoadingViewController()
    
    private let cameraButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "camera"), style: .plain, target: nil, action: #selector(takePhoto))
        return button
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.identifier)
        return collectionView
    }()
    
    private var photos: [PhotoViewModel] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.collectionView.reloadData()
                
                if self.photos.isEmpty {
                    self.emptyLabel.isHidden = false
                    self.collectionView.isHidden = true
                } else {
                    self.emptyLabel.isHidden = true
                    self.collectionView.isHidden = false
                }
            }
        }
    }
    
    private let emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "No Photos yet"
        label.textAlignment = .center
        label.textColor = .systemGray3
        label.isHidden = true
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(emptyLabel)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        setupNavbarItem()
        setupCollectionView()
        setupEmptyLabel()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter?.viewWillDissappear()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        navigationItem.largeTitleDisplayMode = .never
        presenter?.triggerPhotosUpdate()
    }
    
    fileprivate func setupEmptyLabel() {
        emptyLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    fileprivate func setupCollectionView() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    fileprivate func setupNavbarItem() {
        cameraButton.target = self
        if #available(iOS 14.0, *) {
            let renameItem = UIAction(
                title: "Rename Album",
                image: UIImage(systemName: "pencil")
            ) { _ in
                self.editAlbum()
            }
            
            let deleteItem = UIAction(
                title: "Delete Album",
                image: UIImage(systemName: "trash"),
                attributes: .destructive
            ) { _ in
                self.deleteAlbum()
            }
            
            let menu = UIMenu(
                children: [
                    renameItem,
                    deleteItem
                ]
            )
            
            let moreButton = UIBarButtonItem(
                image: UIImage(systemName: "ellipsis.circle"),
                primaryAction: nil,
                menu: menu
            )
            navigationItem.rightBarButtonItems = [
                moreButton,
                cameraButton
            ]
        } else {
            let deleteButton = UIBarButtonItem(
                image: UIImage(systemName: "trash")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal),
                style: .plain,
                target: self,
                action: #selector(deleteAlbum)
            )
            
            let editButton = UIBarButtonItem(
                image: UIImage(systemName: "pencil"),
                style: .plain,
                target: self,
                action: #selector(editAlbum)
            )
            navigationItem.rightBarButtonItems = [
                deleteButton,
                editButton,
                cameraButton
            ]
        }
    }
    
    @objc private func takePhoto() {
        AVCaptureDevice.requestAccess(for: .video) { response in
            if response {
                DispatchQueue.main.async { [weak self] in
                    self?.presenter?.presentCameraView()
                }
            }
        }
    }
    
    @objc private func takePhotoBlocked() {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: "Locked", message: "You are outside GeoBooth collection region", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self?.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc private func deleteAlbum() {
        let alertControlller = UIAlertController(title: "Are you sure do you want delete this album", message: nil, preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [unowned alertControlller] _ in
            self.presenter?.deleteAlbum()
            alertControlller.dismiss(animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { [unowned alertControlller] _ in
            alertControlller.dismiss(animated: true)
        }
        
        alertControlller.addAction(deleteAction)
        alertControlller.addAction(cancelAction)
        present(alertControlller, animated: true)
    }
    
    @objc private func editAlbum() {
        let alertControlller = UIAlertController(title: "New Album name", message: nil, preferredStyle: .alert)
        alertControlller.addTextField()
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned alertControlller] _ in
            if let newAlbumName = alertControlller.textFields?[0].text {
                if !newAlbumName.isEmpty {
                    self.presenter?.editAlbum(newAlbumName: newAlbumName)
                }
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { [unowned alertControlller] _ in
            alertControlller.dismiss(animated: true)
        }
        
        alertControlller.addAction(submitAction)
        alertControlller.addAction(cancelAction)
        
        present(alertControlller, animated: true)
    }
    
    @objc private func deletePhoto() {
        print("Delete Photo")
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: "Delete Photo", message: "Are you sure want to delete this photo?", preferredStyle: .actionSheet)
            
            alert.addAction(
                UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
                    guard let selectedImage = self?.selectedImage else { return }
                    self?.presenter?.triggerPhotoDeletion(photo: selectedImage)
                })
            )
            alert.addAction(
                UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            )
            
            self?.present(alert, animated: true, completion: nil)
        }
    }
    
}

extension CollectionDetailViewController: CollectionDetailViewProtocol {
    func displayPhotos(photos: [PhotoViewModel]) {
        self.photos = photos
    }
    
    func updateViewSuccess(newAlbumName: String) {
        DispatchQueue.main.async { [weak self] in
            self?.navigationItem.title = newAlbumName
            let alert = UIAlertController(title: "Success", message: "Successfully update album name", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self?.present(alert, animated: true, completion: nil)
        }
    }
    
    func updateViewFailed(errorMessage: String) {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
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
    
    func updateViewDeleteSuccess() {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: "Success", message: "Successfully delete album", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                self?.navigationController?.popViewController(animated: true)
            }))
            self?.present(alert, animated: true, completion: nil)
        }
    }
    
    func updateCameraInRegion() {
        cameraButton.image = UIImage(systemName: "camera")
        cameraButton.action = #selector(takePhoto)
    }
    
    func updateCameraOutRegion() {
        cameraButton.image = UIImage(systemName: "lock")
        cameraButton.action = #selector(takePhotoBlocked)
    }
}

extension CollectionDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PhotoCell.identifier,
                for: indexPath
            ) as? PhotoCell
        else { return UICollectionViewCell() }
        if let imageUrl = URL(string: photos[indexPath.row].photoUrl) {
            cell.imageView.kf.setImage(with: imageUrl)
        } else {
            cell.imageView.image = UIImage(systemName: "photos.fill")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard
            let photoCell = collectionView.cellForItem(at: indexPath) as? PhotoCell,
            let image = photoCell.imageView.image
        else { return }
        
        selectedImage = photos[indexPath.row]
        
        presenter?.presentFullImage(image: image, selector: #selector(deletePhoto))
    }
}

extension CollectionDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 3
        return CGSize(width: width, height: width)
    }
}
