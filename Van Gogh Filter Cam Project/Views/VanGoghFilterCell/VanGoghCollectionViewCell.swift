//
//  VanGoghCollectionViewCell.swift
//  VanGogh Cam
//
//  Created by Marios Bousios on 1/8/21.
//

import UIKit

protocol FilterIndexDelegate {
    func justChoseFilter(with index: Int)
}

class VanGoghCollectionViewCell: UICollectionViewCell {
    
    // IB Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var infoTextView: UITextView!
    @IBOutlet weak var chooseButton: UIButton!
    
    // Properties
    var vanGoghFilter: VanGoghFilter?
    var filterIndex: Int?
    var filterIndexDeleagate: FilterIndexDelegate?
    
    // IB Action - Choose button tapped
    @IBAction func chooseButtonTapped() {
        guard let index = filterIndex else { return }
        filterIndexDeleagate?.justChoseFilter(with: index)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
    }
}

//MARK: UI CONFIGURATION
extension VanGoghCollectionViewCell {
    private func configureUI() {
        setCellView()
        setImageView()
        setNameLabel()
        setInfoTextView()
        setChooseButton()
    }
    
    // Cell view setup
    private func setCellView() {
        self.backgroundColor = Colors.Blue.deep
        self.layer.cornerRadius = 40
        self.setShadow(opacity: 0.3)
    }
    
    // Image view setup
    private func setImageView() {
        imageView.layer.cornerRadius = 30
    }
    
    // Name label setup
    private func setNameLabel() {
        nameLabel.applyFont(type: .bold, size: 15)
        nameLabel.fitInWidth()
        nameLabel.textColor = Colors.Yellow.basic
    }
    
    // Text view setup
    private func setInfoTextView() {
        infoTextView.font = UIFont(name: Strings.Font.medium, size: 11)
        infoTextView.textColor = #colorLiteral(red: 0.8509803922, green: 0.8509803922, blue: 0.9294117647, alpha: 1)
    }
    
    // Choose button setup
    private func setChooseButton() {
        chooseButton.basicAppButton(title: Strings.Buttons.choose, backgroundColor: Colors.Yellow.basic)
        chooseButton.setTitleColor(Colors.Blue.deep, for: .normal)
        chooseButton.titleLabel?.applyFont(type: .bold, size: 14)
    }
}
