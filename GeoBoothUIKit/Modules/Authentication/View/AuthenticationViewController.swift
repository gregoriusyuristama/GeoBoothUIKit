//
//  AuthenticationViewController.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 3/13/24.
//

import UIKit
import SnapKit

class AuthenticationViewController: UIViewController, AuthenticationViewProtocol {

    var presenter: (any AuthenticationPresenterProtocol)?
    
    private var titleLabel: UILabel = {
        var label = UILabel()
        label.text = "GeoBooth"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 48, weight: .bold)
        return label
    }()
    
    private var subtitleLabel: UILabel = {
        var label = UILabel()
        label.text = "Capture Memories Right Where It Happen"
        label.textColor = .systemGray2
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        return label
    }()
    
    private var userNameTextField: UITextField = {
        var textField = UITextField()
        textField.placeholder = "Username"
        textField.borderStyle = .roundedRect
        
        return textField
    }()
    
    private var passwordTextField: UITextField = {
        var textField = UITextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.borderStyle = .roundedRect
        
        return textField
    }()
    
    private var signInButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("Sign in", for: .normal)
        button.layer.cornerRadius = 12
        return button
    }()
    
    private var spinner = LoadingViewController()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(titleLabel)
        self.view.addSubview(subtitleLabel)
        self.view.addSubview(userNameTextField)
        self.view.addSubview(passwordTextField)
        self.view.addSubview(signInButton)
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-200)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel).offset(60)
        }
        
        userNameTextField.snp.makeConstraints { make in
            make.width.equalToSuperview().inset(16)
            make.centerX.equalToSuperview()
            make.top.equalTo(subtitleLabel).offset(40)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.width.equalToSuperview().inset(16)
            make.centerX.equalToSuperview()
            make.top.equalTo(userNameTextField).offset(50)
        }
        
        signInButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(16)
            make.top.equalTo(passwordTextField).offset(50)
        }
        
        self.signInButton.addTarget(self, action: #selector(buttonClickedDown), for: [.touchDown, .touchDragEnter])
        self.signInButton.addTarget(self, action: #selector(buttonClickedUp), for: [.touchDragExit, .touchCancel, .touchUpInside, .touchUpOutside])
        
    }
    
    @objc func buttonClickedDown(sender: UIButton) {
        animateButton(sender, transform: CGAffineTransform.identity.scaledBy(x: 0.95, y: 0.95))
        guard let email = userNameTextField.text, let password = passwordTextField.text else { return }
        presenter?.signInWithEmailPassword(email: email, password: password)
    }
    @objc func buttonClickedUp(sender: UIButton) {
        animateButton(sender, transform: .identity)
    }
    
    fileprivate func animateButton(_ viewToAnimate: UIView, transform: CGAffineTransform) {
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 3, options: .curveEaseInOut) {
            viewToAnimate.transform = transform
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
    
    func updateViewWithError(errorMessage: String) {
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
