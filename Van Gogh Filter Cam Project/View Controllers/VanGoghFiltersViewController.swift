//
//  VanGoghFiltersViewController.swift
//  VanGogh Cam
//
//  Created by Marios Bousios on 1/8/21.
//

import UIKit

protocol ChosenVanGoghFilterDelegate {
    func justChoseVanGoghFilter(filter: VanGoghFilter)
}

class VanGoghFiltersViewController: UIViewController {
    
    // IB Outlets
    @IBOutlet weak var dismissView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // Properties
    let vanGoghFiltersManager = VanGoghFiltersManager()
    var vanGoghFilters = [VanGoghFilter]()
    var chosenVanGoghFilterDelegate: ChosenVanGoghFilterDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fillVanGoghFilters()
        setCollectionView()
        configureUI()
    }
    
    // Van Gogh filters array fill
    private func fillVanGoghFilters() {
        vanGoghFilters = vanGoghFiltersManager.getVanGoghFilters()
    }
    
    // Collection view setup
    private func setCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        
        collectionView.collectionViewLayout = flowLayout
        
        let nib = UINib(nibName: Strings.Nib.VanGoghCollectionViewCell, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: Strings.Cell.vanGoghCollectionViewCellID)
    }
}

//MARK: DELEGATE METHODS
extension VanGoghFiltersViewController: FilterIndexDelegate {
    // User just chose a Van Gogh filter
    func justChoseFilter(with index: Int) {
        self.dismiss(animated: true) {
            self.chosenVanGoghFilterDelegate?.justChoseVanGoghFilter(filter: self.vanGoghFilters[index])
        }
    }
}

//MARK: COLLECTION VIEW METHODS
extension VanGoghFiltersViewController: UICollectionViewDelegate, UICollectionViewDataSource,
                                        UICollectionViewDelegateFlowLayout {
    // Van Gogh filters number to display
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vanGoghFilters.count
    }
    
    // Gives a size to each item
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.frame.size.width - 40
        let height: CGFloat = 200
        return CGSize(width: width, height: height)
    }
    
    // Defines cell's line spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    // Defines cell's inset spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 10, bottom: 20, right: 10)
    }
    
    // Creates the cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Dequeue cell
        let id = Strings.Cell.vanGoghCollectionViewCellID
        let dequeueCell = collectionView.dequeueReusableCell(withReuseIdentifier: id, for: indexPath)
        guard let cell = dequeueCell as? VanGoghCollectionViewCell else { return dequeueCell }
        
        // Fill cell's data
        cell.vanGoghFilter = vanGoghFilters[indexPath.row]
        cell.imageView.image = vanGoghFilters[indexPath.row].image
        cell.nameLabel.text = vanGoghFilters[indexPath.row].name
        cell.infoTextView.text = vanGoghFilters[indexPath.row].info
        
        cell.filterIndex = indexPath.row
        cell.filterIndexDeleagate = self
        
        // Returns the cell
        return cell
    }
}

//MARK: UI CONFIGURATION
extension VanGoghFiltersViewController {
    private func configureUI() {
        setDismissView()
        setupTitleLabel()
    }
    
    // Dismiss view setup
    private func setDismissView() {
        dismissView.makeRound()
    }
    
    // Title label setup
    private func setupTitleLabel() {
        titleLabel.text = Strings.chooseVanGogh
        titleLabel.textColor = Colors.Blue.basic
        titleLabel.applyFont(type: .bold, size: 22)
        titleLabel.numberOfLines = 2
        titleLabel.fitInWidth()
    }
}
