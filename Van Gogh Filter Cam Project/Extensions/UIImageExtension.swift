//
//  UIImageExtension.swift
//  VanGogh Cam
//
//  Created by Marios Bousios on 1/8/21.
//

import VideoToolbox
import UIKit

extension UIImage {
    
    // Creates the UIImage with a pixelBuffer
    public convenience init?(pixelBuffer: CVPixelBuffer) {
        var cgImage: CGImage?
        
        VTCreateCGImageFromCVPixelBuffer(pixelBuffer, options: nil, imageOut: &cgImage)
        guard let cgImage = cgImage else { return nil }

        self.init(cgImage: cgImage)
    }
    
    // Sets image as straight up orientation
    func fixOrientation() -> UIImage? {
            if self.imageOrientation == UIImage.Orientation.up {
                return self
            }
            UIGraphicsBeginImageContext(self.size)
            self.draw(in: CGRect(origin: .zero, size: self.size))
            let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return normalizedImage
        }
}
