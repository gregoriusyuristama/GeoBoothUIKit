//
//  SettingViewController.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 3/31/24.
//

import UIKit

class SettingViewController: UITableViewController {
    var presenter: (any SettingPresenterProtocol)?
    private var spinner = LoadingViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Customize navigation item if needed
        navigationItem.title = "Settings"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.tableFooterView = UIView() // This removes empty cells at the bottom of the table view
    }
    
    // MARK: - UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1 // Example: Two sections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        switch indexPath.row {
        case 0:
            if #available(iOS 14.0, *) {
                var content = cell.defaultContentConfiguration()
                
                content.image = UIImage(systemName: "rectangle.portrait.and.arrow.right")
                content.text = "Sign Out"
                content.imageProperties.tintColor = .red
                content.textProperties.color = .red
                
                cell.contentConfiguration = content
            } else {
                cell.textLabel?.text = "Sign Out"
                cell.imageView?.image = UIImage(systemName: "rectangle.portrait.and.arrow.right")
                cell.tintColor = .red
                cell.textLabel?.textColor = .red
            }
            
        default:
            break
        }
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            displayLogoutAlert()
        default:
            break
        }
    }
    
    private func displayLogoutAlert() {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: "Logout Confirmation", message: "Are you sure want to logout?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { [weak self] _ in
                guard let self = self else { return }
                self.presenter?.doLogout()
            }))
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
            self?.present(alert, animated: true, completion: nil)
        }
    }
}

extension SettingViewController: SettingViewProtocol {
    func updateViewLogoutSuccess() {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: "Logout Success", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { [weak self] _ in
                guard let self = self else { return }
                self.presenter?.logoutSuccessPopToAuth()
            }))
            self?.present(alert, animated: true, completion: nil)
        }
    }
    
    func updateViewLogoutFailed(errorMessage: String) {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self?.present(alert, animated: true, completion: nil)
        }
    }
    
    func updateViewIsLoading() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.addChild(self.spinner)
            self.spinner.view.frame = self.tableView.frame
            self.spinner.view.center = self.tableView.center
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
}
