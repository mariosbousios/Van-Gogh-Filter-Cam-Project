//
//  UIButtonExtension.swift
//  GrafaWallpapers
//
//  Created by Marios Bousios on 6/3/21.
//

import Foundation
import UIKit

extension UIButton {
    
    // Creates a basic app button
    func basicAppButton(title: String, backgroundColor: UIColor) {
        self.setTitle(title, for: .normal)
        self.backgroundColor = backgroundColor
        self.tintColor = .white
        self.titleLabel?.fitInWidth()
        self.paddingOnEdges()
        self.makeRound()
    }
    
    // Give button content paddings
    func paddingOnEdges() {
        self.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    // Applies aplha to button
    func applyAlpha(_ apply: Bool) {
        if apply { self.alpha = 0.5 } else { self.alpha = 1 } 
    }
    
    // Disable button
    func disable(with color: UIColor) {
        self.isEnabled = false
        self.backgroundColor = color
    }
    
    // Anable button
    func enable(with color: UIColor) {
        self.isEnabled = true
        self.backgroundColor = color
    }
}
