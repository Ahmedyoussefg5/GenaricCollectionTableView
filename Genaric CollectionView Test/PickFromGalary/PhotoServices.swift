//
//  PhotosManger.swift
//  Test
//
//  Created by Youssef on 4/28/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

//import Foundation
//import MobileCoreServices
import UIKit
//import AVFoundation
import Photos


class PhotoServices: NSObject {
    
    static let shared = PhotoServices()
    
//    typealias videoComp = ((_ url: URL) -> Void)?
    internal var imageComp: ((UIImage) -> Void)!
    
    internal let picker = UIImagePickerController()
    
    override private init() {
        super.init()
        picker.allowsEditing = true
        picker.modalPresentationStyle = .fullScreen
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        picker.delegate = self
    }
    
//    func getVideoFromCameraRoll(on: UIViewController, completion: @escaping (_ image: URL)->()) {
//
//        picker.sourceType = .photoLibrary
//        picker.mediaTypes = [kUTTypeMovie as String]
//
//        DispatchQueue.main.async {[weak self] in
//            guard let self = self else { return }
//            on.present(self.picker, animated: true) {
//                //                self.completion = completion
//            }
//        }
//    }
    
    func getImageFromGalary(on: UIViewController, completion: @escaping (_ image: UIImage?)->()) {
        requestAuthorization {[weak self] (status) in
            if status {
                guard let self = self else { return }
                self.picker.sourceType = .photoLibrary
                DispatchQueue.main.async {
                    on.present(self.picker, animated: true) {
                        self.imageComp = completion
                    }
                }
            } else {
                completion(nil)
            }
        }
    }
    
    private func requestAuthorization(completion: @escaping (_ status: Bool) -> Void){
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        
        switch photoAuthorizationStatus {
        case .authorized:
            completion(true)
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization ({ newStatus in
                if newStatus == PHAuthorizationStatus.authorized {
                    completion(true)
                } else {
                    completion(false)
                }
            })
        case .restricted:
            completion(false)
            print("User do not have access to photo album.")
        case .denied:
            completion(false)
            print("User has denied the permission.")
        }
    }
}

//
// MARK: UIImagePickerControllerDelegate methods
//
extension PhotoServices: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let editedImage = info[.editedImage] as? UIImage {
            DispatchQueue.main.async {[weak self] in
                self?.picker.dismiss(animated: true) {
                    self?.imageComp(editedImage)
                }
            }
        } else if let originalImage = info[.originalImage] as? UIImage {
            DispatchQueue.main.async {[weak self] in
                self?.picker.dismiss(animated: true) {
                    self?.imageComp(originalImage)
                }
            }
        } else {
            picker.dismiss(animated: true)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

//
// MARK:- GetThumbnail
//
extension PhotoServices {
    func getThumbnailFrom(path: URL) -> UIImage? {
        do {
            
            let asset = AVURLAsset(url: path , options: nil)
            let imgGenerator = AVAssetImageGenerator(asset: asset)
            imgGenerator.appliesPreferredTrackTransform = true
            let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(value: 0, timescale: 1), actualTime: nil)
            let thumbnail = UIImage(cgImage: cgImage)
            return thumbnail
        } catch let error {
            print("*** Error generating thumbnail: \(error.localizedDescription)")
            return nil
        }
    }
}

// Orignal
//
//  PhotoServices.swift
//  ThumbnailTestProject
//
//  Created by David Seek on 10/12/17.
//  Copyright © 2017 David Seek. All rights reserved.
//


//import Foundation
//import MobileCoreServices
//import UIKit
//import AVFoundation
//
//
//class PhotoServices: NSObject {
//    
//    
//    static let shared = PhotoServices()
//    
//    internal var completion: ((URL)->Void)!
//    internal let picker = UIImagePickerController()
//    
//    override init() {
//        
//        super.init()
//        
//        self.picker.allowsEditing = false
//        self.picker.modalPresentationStyle = .fullScreen
//        self.picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
//        self.picker.delegate = self
//        
//    }
//    
//    func getVideoFromCameraRoll(on: UIViewController, completion: @escaping (_ image: URL)->()) {
//        
//        self.picker.sourceType = .photoLibrary
//        self.picker.mediaTypes = [kUTTypeMovie as String]
//        
//        DispatchQueue.main.async {
//            on.present(self.picker, animated: true) {
//                self.completion = completion
//            }
//        }
//        
//    }
//    
//    
//    
//}
//
////
////
//// MARK: UIImagePickerControllerDelegate methods
//extension PhotoServices: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//    
//    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        
//        if let url = info[UIImagePickerControllerMediaURL] as? URL {
//            
//            DispatchQueue.main.async {
//                self.picker.dismiss(animated: true) {
//                    
//                    self.completion(url)
//                    
//                }
//            }
//            
//        }
//        
//    }
//    
//    
//}
//
////
////
//// MARK: Thumbnail
//extension PhotoServices {
//    
//    
//    func getThumbnailFrom(path: URL) -> UIImage? {
//        
//        do {
//            
//            let asset = AVURLAsset(url: path , options: nil)
//            let imgGenerator = AVAssetImageGenerator(asset: asset)
//            imgGenerator.appliesPreferredTrackTransform = true
//            let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(0, 1), actualTime: nil)
//            let thumbnail = UIImage(cgImage: cgImage)
//            
//            return thumbnail
//            
//        } catch let error {
//            
//            print("*** Error generating thumbnail: \(error.localizedDescription)")
//            return nil
//            
//        }
//        
//    }
//    
//    
//}

