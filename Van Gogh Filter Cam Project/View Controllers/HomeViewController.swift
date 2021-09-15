//
//  ViewController.swift
//  VanGogh Cam
//
//  Created by Marios Bousios on 30/7/21.
//

import UIKit
import PhotosUI
import CoreML
import Vision
import CoreImage

class HomeViewController: UIViewController {
    
    // IB Connections
    @IBOutlet weak var saveBarButton: UIButton!
    @IBOutlet weak var addBarButton: UIButton!
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var filtersContainerView: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var vanGoghStyleButton: UIButton!
    @IBOutlet weak var filterNameLabel: UILabel!
    @IBOutlet weak var sliderBar: UISlider!
    
    // Properties
    let vanGoghFiltersManager = VanGoghFiltersManager()
    var photoPickerManager: PhotoPickerManager!
    var vanGoghFilter: VanGoghFilter?
    var originalImage: UIImage?
    var vanGoghImage: UIImage?
    
    var context: CIContext!
    var currentFilter: CIFilter!
    
    // IB Action - Add image button tapped
    @IBAction func addButtonTapped(sender: UIButton) {
        photoPickerManager.presentMediaSourceOptions(with: sender)
    }
    
    // IB Action - Save image button tapped
    @IBAction func saveImageButtonTapped() {
        guard let image = vanGoghImage else { return }
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    // IB Action - Control changes happened
    @IBAction func segmentedControlValueChanged(_ sender: Any) {
        if segmentedControl.selectedSegmentIndex == 0 {
            imageView.image = vanGoghImage
        } else { imageView.image = originalImage }
    }
    
    // IB Action - Van Gogh style options button tapped
    @IBAction func vanGoghStyleButtonTapped() {
        presentVanGoghFiltersScreen()
    }
    
    // IB Action - Filter slide bar changed
    @IBAction func slideBarChanged(_ sender: Any) {
        segmentedControl.selectedSegmentIndex = 0
        applyFilterProcessing()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoPickerManager = PhotoPickerManager(vc: self)
        setupSharpnessFilter()
        configureUI()
        setStartingScreen()
    }
    
    // Sharpness filter setup
    private func setupSharpnessFilter() {
        context = CIContext()
        currentFilter = CIFilter(name: Strings.Filter.sharpness)
    }
    
    // Setup of standard filter process
    private func setupStandardFilterProcess() {
        guard let image = vanGoghImage else { return }
        let beginImage = CIImage(image: image)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        
        applyFilterProcessing()
    }
    
    // Starting screen setup
    private func setStartingScreen() {
        let id = Strings.ViewControllerID.startingScreenVCID
        if let vc = storyboard?.instantiateViewController(withIdentifier: id) as? StartingScreenViewController {
            vc.sendFilterFromStartingDelegate = self
            present(vc, animated: true, completion: nil)
        }
    }
    
    // Presents Van Gogh Filters screen
    private func presentVanGoghFiltersScreen() {
        let id = Strings.ViewControllerID.vanGoghFiltersVCID
        if let vc = storyboard?.instantiateViewController(withIdentifier: id) as? VanGoghFiltersViewController {
            vc.chosenVanGoghFilterDelegate = self
            present(vc, animated: true, completion: nil)
        }
    }
    
    // Updates UI after new image import or filter applyied
    private func updateUIImageState(for newImage: UIImage) {
        originalImage = newImage
        vanGoghImage = newImage
        imageView.image = newImage.fixOrientation()
        segmentedControl.selectedSegmentIndex = 0
    }
    
    // Applies the selected Van Gogh filter to thse current image
    private func applyVanGoghStlyle(for painting: VanGoghPainting) {
        // Set image back to original view BEFORE styling, to avoid double stylization
        self.imageView.image = self.originalImage?.fixOrientation()
        segmentedControl.selectedSegmentIndex = 0
        self.saveBarButton.isEnabled = false
        self.currentFilter.setValue(0, forKey: kCIInputIntensityKey)
        self.sliderBar.setValue(0, animated: true)
        
        // Convert UIImage to CIImage
        guard let uiimage = imageView.image else { return }
        guard let ciimage = CIImage(image: uiimage) else { return }

        // Define model with configuaretion
        let config = MLModelConfiguration()
        guard let model = getVNModel(for: painting, with: config) else { return }

        // The ML Request
        let request = VNCoreMLRequest(model: model) { (request, error) in
            if let _ = error { return }
            
            // Get the results as Pixel buffer from the calculations
            guard let results = request.results as? [VNPixelBufferObservation] else { return }
            guard let observation = results.first else { return }

            // Update the UI in the main thread
            DispatchQueue.main.async(execute: {
                self.vanGoghImage = UIImage(pixelBuffer: observation.pixelBuffer)
                self.imageView.image = self.vanGoghImage?.fixOrientation()
                self.setupStandardFilterProcess()
                self.saveBarButton.isEnabled = true
            })
        }
        
        // Define a request handler and perform it
        let handler = VNImageRequestHandler(ciImage: ciimage, options: [:])
        try? handler.perform([request])
    }
    
    // Returns the model based on the painting type passed
    private func getVNModel(for painting: VanGoghPainting, with config: MLModelConfiguration) -> VNCoreMLModel? {
        switch painting {
        case .starryNight:
            if let model = try? VNCoreMLModel(for: StarryNight.init(configuration: config).model) { return model }
        case .cafeTerrace:
            if let model = try? VNCoreMLModel(for: CafeTerrace.init(configuration: config).model) { return model }
        case .almondBlossom:
            if let model = try? VNCoreMLModel(for: AlmondBlossom.init(configuration: config).model) { return model }
        case .potatoEaters:
            if let model = try? VNCoreMLModel(for: PotatoEaters.init(configuration: config).model) { return model }
        }
        
        return nil
    }
    
    // Applies the filter from the slidebar
    private func applyFilterProcessing() {
        currentFilter.setValue(sliderBar.value * 10, forKey: kCIInputIntensityKey)
        
        guard let outputImage = currentFilter.outputImage else { return }
        if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            let processedImage = UIImage(cgImage: cgImage)
            vanGoghImage = processedImage
            imageView.image = vanGoghImage?.fixOrientation()
        }
    }
}

//MARK: DELEGATE METHODS
extension HomeViewController: SendFilterFromStartingDelegate, ChosenVanGoghFilterDelegate {
    // Filter sent from starting page
    func getVanGoghFilterFromStarting(filter: VanGoghFilter, for image: UIImage) {
        vanGoghFilter = filter
        updateUIImageState(for: image)
        
        guard let paintingType = filter.painting else { return }
        applyVanGoghStlyle(for: paintingType)
    }
    
    // Gets filter from VanGoghFiltersVC
    func justChoseVanGoghFilter(filter: VanGoghFilter) {
        vanGoghFilter = filter
        guard let paintingType = filter.painting else { return }
        applyVanGoghStlyle(for: paintingType)
    }
}
//MARK: PHOTO & IMAGE PICKER METHODS
extension HomeViewController: PHPickerViewControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // Just selected a photo from the library
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true, completion: nil)
        
        guard !results.isEmpty else { return }
        results.forEach { result in
            result.itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                guard let image = image as? UIImage, error == nil else {
                    // Failed case
                    let alertVC = UIAlertController(title: Strings.Alert.failedTitle, message: Strings.Alert.failedImportingImageMessage, preferredStyle: .alert)
                    DispatchQueue.main.async {
                        self.present(alertVC, animated: true, completion: nil)
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        alertVC.dismiss(animated: true, completion: nil)
                    }
                    return
                }
                // Succeed case
                DispatchQueue.main.async {
                    self.updateUIImageState(for: image)
                    self.presentVanGoghFiltersScreen()
                }
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let pickedImage = info[.originalImage] as? UIImage else {
            // Failed picking image from camera
            let alertVC = UIAlertController(title: Strings.Alert.failedTitle, message: Strings.Alert.failedImportingMessage, preferredStyle: .alert)
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
            self.updateUIImageState(for: pickedImage)
            self.presentVanGoghFiltersScreen()
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    // Finished trying to save image to the photo library
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        let alertVC = UIAlertController(title: "", message: "", preferredStyle: .alert)
        
        if let _ = error {
            alertVC.title = Strings.Alert.failedTitle
            alertVC.message = Strings.Alert.failedSavingMessage
        } else {
            alertVC.title = Strings.Alert.successSavingTitle
            alertVC.message = Strings.Alert.successSavingMessage
        }
        
        present(alertVC, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            alertVC.dismiss(animated: true, completion: nil)
        })
    }
}

//MARK: UI CONFIGURATION
extension HomeViewController {
    private func configureUI() {
        setupBarItems()
        setupSegmentedControl()
        setupImageContainerView()
        setupFilterContainerView()
        setupVanGoghStyleButton()
    }
    
    // Bar items setup
    private func setupBarItems() {
        // Save Button Configuration
        saveBarButton.setTitle(Strings.Buttons.save, for: .normal)
        saveBarButton.titleLabel?.fitInWidth()
        saveBarButton.isEnabled = false
    }
    
    // Segmented control setup
    private func setupSegmentedControl() {
        segmentedControl.setTitle(Strings.SegmentedControl.vanGogh, forSegmentAt: 0)
        segmentedControl.setTitle(Strings.SegmentedControl.original, forSegmentAt: 1)
        segmentedControl.selectedSegmentTintColor = Colors.Yellow.basic
        segmentedControl.backgroundColor = Colors.Blue.basic
        
        let selectedAttr = [NSAttributedString.Key.foregroundColor: UIColor.white,
                            NSAttributedString.Key.font: UIFont(name: Strings.Font.bold, size: 14)]
        let deselectedAttr = [NSAttributedString.Key.foregroundColor: Colors.Blue.dark,
                              NSAttributedString.Key.font: UIFont(name: Strings.Font.bold, size: 14)]
        
        segmentedControl.setTitleTextAttributes(selectedAttr as [NSAttributedString.Key : Any], for: .selected)
        segmentedControl.setTitleTextAttributes(deselectedAttr as [NSAttributedString.Key : Any], for: .normal)
    }
    
    // Image container view setup
    private func setupImageContainerView() {
        imageContainerView.layer.cornerRadius = 40
        imageContainerView.setShadow(opacity: 0.3)
        imageView.layer.cornerRadius = 15
    }

    // Van Gogh style button setup
    private func setupVanGoghStyleButton() {
        vanGoghStyleButton.basicAppButton(title: Strings.Buttons.chooseStyle, backgroundColor: Colors.Blue.basic)
        vanGoghStyleButton.titleLabel?.applyFont(type: .bold, size: 15)
    }
    
    // Filter container view setup
    private func setupFilterContainerView() {
        filtersContainerView.layer.cornerRadius = 40
        filtersContainerView.setShadow(opacity: 0.3)
        
        // Filter name label setup
        filterNameLabel.text = Strings.intensity
        filterNameLabel.applyFont(type: .medium, size: 16)
        filterNameLabel.fitInWidth()
        filterNameLabel.textColor = .white
        
        // Slide bar setup
        sliderBar.tintColor = Colors.Yellow.basic
        sliderBar.setValue(0, animated: false)
    }
}
