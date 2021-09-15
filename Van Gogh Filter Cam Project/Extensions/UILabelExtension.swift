//
//  UILabelExtension.swift
//  Wordman
//
//  Created by Marios Bousios on 19/3/21.
//

import Foundation
import UIKit

extension UILabel {
    
    // Fits label in containers width
    func fitInWidth() {
        self.adjustsFontSizeToFitWidth = true
    }
    
    // Apply font
    func applyFont(type: FontType, size: CGFloat) {
        switch type {
        case .regualar:
            self.font = UIFont(name: Strings.Font.regular, size: size)
        case .medium:
            self.font = UIFont(name: Strings.Font.medium, size: size)
        case .light:
            self.font = UIFont(name: Strings.Font.light, size: size)
        case .bold:
            self.font = UIFont(name: Strings.Font.bold, size: size)
        case .black:
            self.font = UIFont(name: Strings.Font.black, size: size)
        case .italic:
            self.font = UIFont(name: Strings.Font.italic, size: size)
        case .mediumItalic:
            self.font = UIFont(name: Strings.Font.mediumItalic, size: size)
        case .lightItalic:
            self.font = UIFont(name: Strings.Font.lightItalic, size: size)
        case .boldItalic:
            self.font = UIFont(name: Strings.Font.boldItalic, size: size)
        case .blackItalic:
            self.font = UIFont(name: Strings.Font.blackItalic, size: size)
        }
    }
}
