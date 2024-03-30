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
    
    var capturedImageView: UIImageView?
    
    var presenter: (any CameraPresenterProtocol)?
    
    private var spinner = LoadingViewController()
    
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
        
        shutterButton.snp.makeConstraints { [weak self] make in
            guard let self = self else { return }
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.view.snp.bottomMargin).inset(20)
            make.width.height.equalTo(80)
        }
        
        shutterButton.addTarget(
            self,
            action: #selector(takePhoto),
            for: .touchUpInside
        )
        
        view.addSubview(flipCameraButton)
        flipCameraButton.snp.makeConstraints { [weak self] make in
            guard let self = self else { return }
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
    
    @objc func savePhoto() {
        guard let imgData = capturedImageView?.image?.jpegData(compressionQuality: 0.5) else { return }
        presenter?.doSavePhoto(imageData: imgData)
    }
    
    @objc func retakePhoto() {
        
        capturedImageView?.removeFromSuperview()
        capturedImageView = nil
        
        navigationItem.rightBarButtonItem = .none
        
        navigationItem.setHidesBackButton(false, animated: true)
        
        navigationItem.leftBarButtonItem = .none
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
        capturedImageView = UIImageView(image: image)
        capturedImageView?.contentMode = .scaleAspectFit
        capturedImageView?.frame = view.bounds
        capturedImageView?.backgroundColor = .black
        capturedImageView?.isUserInteractionEnabled = true
        guard let capturedImageView = capturedImageView else { return }
        view.addSubview(capturedImageView)
        
        let saveBarButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(savePhoto))
        navigationItem.rightBarButtonItem = saveBarButton
        
        let retakeButton = UIBarButtonItem(title: "Retake", style: .plain, target: self, action: #selector(retakePhoto))
        
        navigationItem.rightBarButtonItem = saveBarButton
        
        navigationItem.setHidesBackButton(true, animated: true)
        
        navigationItem.leftBarButtonItem = retakeButton
    }
}

extension CameraViewController: CameraViewProtocol {
    func updateViewSavePhotoSuccess() {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: "Success", message: "Successfully added new photo", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                self?.presenter?.popViewController()
            }))
            self?.present(alert, animated: true, completion: nil)
        }
    }
    
    func updateViewSavePhotoFailed(errorMessage: String) {
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
}
