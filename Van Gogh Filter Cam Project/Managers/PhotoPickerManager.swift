//
//  PhotoPickerManager.swift
//  VanGogh Cam
//
//  Created by Marios Bousios on 30/7/21.
//

import UIKit
import PhotosUI

class PhotoPickerManager {
    
    // Properties
    var vc: UIViewController?
    
    // Initializer
    init(vc: UIViewController) {
        self.vc = vc
    }
    
    // Present photo media source option
    public func presentMediaSourceOptions(with sender: UIButton) {
        // Define AlertVC
        let mediaSourceAlert = UIAlertController(title: "\(Strings.Alert.chooseImageFrom):", message: nil, preferredStyle: .actionSheet)
        
        // Camera Action Alert
        let cameraAction = UIAlertAction(title: Strings.Alert.cameraAction, style: .default) { _ in
            self.openCamera()
        }
        // Gallert Action Alert
        let galleryAction = UIAlertAction(title: Strings.Alert.galleryAction, style: .default) { _ in
            self.presentPHPickerLibrary()
        }
        // Cancel Action Alert
        let cancelAction = UIAlertAction(title: Strings.Alert.cancel, style: .cancel, handler: nil)
        
        // Add Actions to AlertVC
        mediaSourceAlert.addAction(cameraAction)
        mediaSourceAlert.addAction(galleryAction)
        mediaSourceAlert.addAction(cancelAction)
        
        // For ipad; setting source button for popover
        mediaSourceAlert.popoverPresentationController?.sourceView = sender
        mediaSourceAlert.popoverPresentationController?.sourceRect = sender.bounds
        
        // Presents the AlertVC
        vc?.present(mediaSourceAlert, animated: true, completion: nil)
    }
    
    // Opens phone camera
    private func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = vc as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = false
            self.vc?.present(imagePicker, animated: true, completion: nil)
        } else {
            // There is no camera found case - Presents warning alert to tell user
            let alert = UIAlertController(title: "Warning", message: "No camera found", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.vc?.present(alert, animated: true, completion: nil)
        }
    }
    
    // Presents the PHPickerVC
    public func presentPHPickerLibrary() {
        // Configures the PHPicker with image data and one selection only
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 1
        configuration.filter = .images
        
        // Sets the delegate to the passed VC and presents the PHPicker
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = vc as? PHPickerViewControllerDelegate
        vc?.present(picker, animated: true, completion: nil)
    }
}
