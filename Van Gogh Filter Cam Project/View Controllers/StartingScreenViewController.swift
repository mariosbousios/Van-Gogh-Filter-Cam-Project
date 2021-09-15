//
//  StartingScreenViewController.swift
//  VanGogh Cam
//
//  Created by Marios Bousios on 31/7/21.
//

import UIKit
import PhotosUI

protocol SendFilterFromStartingDelegate {
    func getVanGoghFilterFromStarting(filter: VanGoghFilter, for image: UIImage)
}

class StartingScreenViewController: UIViewController {
    
    // IB Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var appImageView: UIImageView!
    
    // Properties
    var photoPickerManager: PhotoPickerManager!
    var sendFilterFromStartingDelegate: SendFilterFromStartingDelegate?
    var selectedImage: UIImage?
    
    // IB Action - Add button tapped
    @IBAction private func addButtonTapped() {
        photoPickerManager.presentMediaSourceOptions(with: addButton)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoPickerManager = PhotoPickerManager(vc: self)
        configureUI()
    }
    
    // Presents Van Gogh Filters screen
    private func presentVanGoghFiltersScreen() {
        let id = Strings.ViewControllerID.vanGoghFiltersVCID
        if let vc = storyboard?.instantiateViewController(withIdentifier: id) as? VanGoghFiltersViewController {
            vc.chosenVanGoghFilterDelegate = self
            present(vc, animated: true, completion: nil)
        }
    }
}

//MARK: DELEGATE METHODS
extension StartingScreenViewController: ChosenVanGoghFilterDelegate {
    func justChoseVanGoghFilter(filter: VanGoghFilter) {
        self.dismiss(animated: true) {
            guard let image = self.selectedImage else { return }
            self.sendFilterFromStartingDelegate?.getVanGoghFilterFromStarting(filter: filter, for: image)
        }
    }
}

//MARK: PHOTO PICKER & IMAGE PICKER METHODS
extension StartingScreenViewController: PHPickerViewControllerDelegate, UIImagePickerControllerDelegate,
                                        UINavigationControllerDelegate {
    // Just selected a photo from the library
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true, completion: nil)
        
        guard !results.isEmpty else { return }
        results.forEach { result in
            result.itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                guard let image = image as? UIImage, error == nil else {
                    let alertVC = UIAlertController(title: Strings.Alert.failedTitle, message: Strings.Alert.failedImportingMessage, preferredStyle: .alert)
                    DispatchQueue.main.async {
                        self.present(alertVC, animated: true, completion: nil)
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        alertVC.dismiss(animated: true, completion: nil)
                    }
                    return
                }
                DispatchQueue.main.async {
                    self.selectedImage = image
                    self.presentVanGoghFiltersScreen()
                }
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let pickedImage = info[.originalImage] as? UIImage else {
            // Failed picking image from camera
            let alertVC = UIAlertController(title: Strings.Alert.failedTitle, message: Strings.Alert.failedImportingImageMessage, preferredStyle: .alert)
            DispatchQueue.main.async {
                self.present(alertVC, animated: true, completion: nil)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                alertVC.dismiss(animated: true, completion: nil)
            }
            picker.dismiss(animated: true, completion: nil)
            return
        }
        // Succeed picking image from camera
        DispatchQueue.main.async {
            self.selectedImage = pickedImage
            self.presentVanGoghFiltersScreen()
        }
        picker.dismiss(animated: true, completion: nil)
    }
}

//MARK: UI CONFIGURATION
extension StartingScreenViewController {
    private func configureUI() {
        appImageViewSetup()
        setTitleLabel()
        setAddButton()
    }
    
    // App image view setup
    private func appImageViewSetup() {
        appImageView.layer.cornerRadius = 40
    }
    
    // Title lebal setup
    private func setTitleLabel() {
        titleLabel.text = Strings.startingLabelText
        titleLabel.textColor = Colors.Blue.basic
        titleLabel.applyFont(type: .bold, size: 22)
        titleLabel.numberOfLines = 2
        titleLabel.fitInWidth()
    }
    
    // Add button setup
    private func setAddButton() {
        addButton.basicAppButton(title: Strings.Buttons.add, backgroundColor: Colors.Yellow.basic)
        addButton.titleLabel?.textColor = Colors.Blue.dark
        addButton.titleLabel?.applyFont(type: .bold, size: 16)
        addButton.tintColor = Colors.Blue.dark
    }
}
