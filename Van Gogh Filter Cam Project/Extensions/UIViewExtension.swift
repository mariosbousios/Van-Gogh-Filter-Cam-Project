//
//  UIViewExtension.swift
//  Wordman
//
//  Created by Marios Bousios on 19/3/21.
//

import Foundation
import UIKit

extension UIView {
    
    // Makes a view rounded
    func makeRound() {
        self.layer.cornerRadius = self.layer.frame.height / 2
    }
    
    // Setting a shadow to the view layer
    func setShadow(opacity: Float) {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = CGSize(width: 0.0, height: 8)
        self.layer.shadowRadius = 5
        self.layer.masksToBounds = false
    }
}
