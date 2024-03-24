//
//  CameraViewController.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 3/24/24.
//

import AVFoundation
import SnapKit
import UIKit

class CameraViewController: UIViewController {
    var captureSession: AVCaptureSession!
    var stillImageOutput: AVCapturePhotoOutput!
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    var currentCamera: AVCaptureDevice.Position = .back
    
    var presenter: (any CameraPresenterProtocol)?
    
    let shutterButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        return button
    }()
    
    let flipCameraButton: UIButton = {
        let button = UIButton()
        let font = UIFont.systemFont(ofSize: 30)
        let config = UIImage.SymbolConfiguration(font: font)
        let image = UIImage(
            systemName: "arrow.triangle.2.circlepath.camera",
            withConfiguration: config
        )?.withTintColor(.white, renderingMode: .alwaysOriginal)
        button.setImage(image, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCamera()
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        shutterButton.layer.cornerRadius = shutterButton.frame.size.width / 2
        shutterButton.clipsToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .black
        tabBarController?.tabBar.isHidden = true
        configureTransparentNavbar()
        if !captureSession.isRunning {
            DispatchQueue.global(qos: .background).async {
                self.captureSession.startRunning()
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        tabBarController?.tabBar.isHidden = false
        if captureSession.isRunning {
            captureSession.stopRunning()
        }
    }
    
    func setupCamera() {
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .photo
        
        guard let backCamera = AVCaptureDevice.default(for: .video) else {
            print("Unable to access back camera")
            return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: backCamera)
            
            stillImageOutput = AVCapturePhotoOutput()
            
            if captureSession.canAddInput(input) && captureSession.canAddOutput(stillImageOutput) {
                captureSession.addInput(input)
                captureSession.addOutput(stillImageOutput)
                setupLivePreview()
            }
        } catch {
            print("Error Unable to initialize back camera: \(error.localizedDescription)")
        }
    }
    
    func setupUI() {
        view.addSubview(shutterButton)
        
        shutterButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.snp.bottomMargin).inset(20)
            make.width.height.equalTo(80)
        }
        
        shutterButton.addTarget(
            self,
            action: #selector(takePhoto),
            for: .touchUpInside
        )
        
        view.addSubview(flipCameraButton)
        flipCameraButton.snp.makeConstraints { make in
            make.leading.equalTo(shutterButton.snp.trailing).offset(40)
            make.bottom.equalToSuperview().inset(80)
        }
               
        flipCameraButton.addTarget(self, action: #selector(flipCamera), for: .touchUpInside)
    }
    
    func setupLivePreview() {
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer.videoGravity = .resizeAspect
        videoPreviewLayer.connection?.videoOrientation = .portrait
        videoPreviewLayer.frame = view.layer.bounds
        view.layer.addSublayer(videoPreviewLayer)
    }
    
    private func configureTransparentNavbar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = UIColor.clear
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance = appearance
    }
    
    @objc func takePhoto() {
        let settings = AVCapturePhotoSettings()
        stillImageOutput.capturePhoto(with: settings, delegate: self)
    }
    
    @objc func flipCamera() {
        captureSession.beginConfiguration()
        for input in captureSession.inputs {
            captureSession.removeInput(input)
        }
        
        currentCamera = currentCamera == .back ? .front : .back
        
        if let newCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: currentCamera) {
            do {
                let newInput = try AVCaptureDeviceInput(device: newCamera)
                if captureSession.canAddInput(newInput) {
                    captureSession.addInput(newInput)
                } else {
                    print("Failed to add input")
                }
            } catch {
                print("Error switching cameras: \(error)")
            }
        } else {
            print("Failed to get new camera")
        }
        
        captureSession.commitConfiguration()
    }
}

extension CameraViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard error == nil else {
            print("Error capturing photo: \(error!)")
            return
        }
        
        guard let imageData = photo.fileDataRepresentation(),
              let image = UIImage(data: imageData)
        else {
            print("Error converting photo data to image")
            return
        }
        
        // Do something with the captured image
        // For example, present it in another view controller
        let capturedImageView = UIImageView(image: image)
        capturedImageView.contentMode = .scaleAspectFit
        capturedImageView.frame = view.bounds
        capturedImageView.backgroundColor = .black
        capturedImageView.isUserInteractionEnabled = true
        view.addSubview(capturedImageView)
    }
}

extension CameraViewController: CameraViewProtocol {}
