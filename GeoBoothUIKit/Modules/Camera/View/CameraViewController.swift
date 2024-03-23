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
    
    let shutterButton: UIButton = {
        let button = UIButton(
            frame: CGRect(x: 0, y: 0, width: 40, height: 40)
        )
        button.backgroundColor = .white
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        view.addSubview(shutterButton)
        
        shutterButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.snp.bottomMargin).inset(20)
        }
        
        shutterButton.addTarget(
            self,
            action: #selector(takePhoto),
            for: .touchUpInside
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !captureSession.isRunning {
            DispatchQueue.global(qos: .background).async {
                self.captureSession.startRunning()
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if captureSession.isRunning {
            captureSession.stopRunning()
        }
    }
    
    func setupLivePreview() {
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer.videoGravity = .resizeAspectFill
        videoPreviewLayer.connection?.videoOrientation = .portrait
        videoPreviewLayer.frame = view.layer.bounds
        view.layer.addSublayer(videoPreviewLayer)
    }
    
    @objc func takePhoto() {
        let settings = AVCapturePhotoSettings()
        stillImageOutput.capturePhoto(with: settings, delegate: self)
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
