//
//  LoadingViewController.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 3/14/24.
//

import Lottie
import SnapKit
import UIKit

class LoadingViewController: UIViewController {
    private var animationView: LottieAnimationView = {
        let view = LottieAnimationView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.1)
        self.setupLottieAnimation()
        self.setupUI()
    }
    
    private func setupLottieAnimation() {
        self.animationView.animation = LottieAnimation.asset("NormalLoading")
        self.animationView.contentMode = .scaleToFill
        self.animationView.backgroundBehavior = .pauseAndRestore
        self.animationView.loopMode = .loop
        self.animationView.animationSpeed = 1.0
        self.animationView.play()
    }
    
    private func setupUI() {
        view.addSubview(self.animationView)
        
        self.animationView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(100)
        }
    }
}
