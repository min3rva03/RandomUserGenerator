//
//  HistoryViewController.swift
//  RandomUserGenerator
//
//  Created by Minerva Nolasco Espino on 17/08/22.
//

import UIKit

class HistoryViewController: UIViewController {
    
    private lazy var usrGeneratorVM = RandomUsrViewModel()
    private let reuseIdentifierCell = "cellCollection"
    
    private var numberOfItemsInRow = 2
    private var minimumSpacing = 5
    private var edgeInsetPadding = 10
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usrGeneratorVM.getInitialData()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
}

extension HistoryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return usrGeneratorVM.getnumberOfRows()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierCell, for: indexPath) as? CustomCollectionCell,
              let usrData = usrGeneratorVM.getCellForRow(index: indexPath.row) else { return UICollectionViewCell() }
        
        if let title = usrData.results?.first?.name?.title,
           let first = usrData.results?.first?.name?.first,
           let last = usrData.results?.first?.name?.last {
            cell.nameLabel.text = "\(title). \(first) \(last)"
        }
        
        if let url = URL(string: usrData.results?.first?.picture?.large ?? ""){
            do {
                let data = try Data(contentsOf: url)
                let image = UIImage(data: data)
                let roundedImage = image?.roundedImage()
                cell.usrImageView.image = roundedImage
            } catch {
                print(error)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let inset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        edgeInsetPadding = Int(inset.left + inset.right)
        return inset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(minimumSpacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(minimumSpacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (Int(UIScreen.main.bounds.size.width) - (numberOfItemsInRow - 1) * minimumSpacing - edgeInsetPadding) / numberOfItemsInRow
        return CGSize(width: width, height: width)
    }
}

class CustomCollectionCell : UICollectionViewCell{
    
    @IBOutlet weak var usrImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
}
