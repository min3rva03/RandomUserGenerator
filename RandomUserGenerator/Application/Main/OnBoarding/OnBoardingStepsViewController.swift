//
//  OnBoardingStepsViewController.swift
//  Finanzas
//
//  Created by Minerva Nolasco Espino on 02/08/22.
//

import UIKit

class OnBoardingStepsViewController: UIViewController {
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var descriptionLabel : UILabel!
    @IBOutlet weak var onBoardingImageLabel : UIImageView!
    
    var item: OnBoardingItem?

    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = item?.title
        descriptionLabel.text = item?.description
        onBoardingImageLabel.image = UIImage(named: item?.imageName ?? "")
    }
}
