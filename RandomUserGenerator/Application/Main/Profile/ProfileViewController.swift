//
//  ProfileViewController.swift
//  RandomUserGenerator
//
//  Created by Minerva Nolasco Espino on 17/08/22.
//

import UIKit
import MapKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var ubicationMap: MKMapView!
    
    @IBAction func generateNewUsr(_ sender: Any) {
        usrGeneratorVM.requestRandomUsrGenerate()
    }
    
    private lazy var usrGeneratorVM = RandomUsrViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.usrGeneratorVM.requestRandomUsrGenerate()
        usrGeneratorVM.randomUsrModel.bind { [weak self] randomUsrModel in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                if let title = randomUsrModel?.results?.first?.name?.title,
                   let first = randomUsrModel?.results?.first?.name?.first,
                   let last = randomUsrModel?.results?.first?.name?.last {
                    self.nameLabel.text = "\(title). \(first) \(last)"
                    self.genderLabel.text = randomUsrModel?.results?.first?.gender
                    self.ageLabel.text = randomUsrModel?.results?.first?.dob?.age.description
                    self.cellLabel.text = randomUsrModel?.results?.first?.cell
                    self.emailLabel.text = randomUsrModel?.results?.first?.email
                }
                if let latitud = randomUsrModel?.results?.first?.location?.coordinates?.latitude,
                   let longitud = randomUsrModel?.results?.first?.location?.coordinates?.longitude{
                    let location = CLLocation(latitude: Double(latitud) ?? 0.0 , longitude: Double(longitud) ?? 0.0)
                    let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
                    self.ubicationMap.setRegion(coordinateRegion, animated: true)
                    
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = CLLocationCoordinate2D(latitude: Double(latitud) ?? 0.0, longitude: Double(longitud) ?? 0.0)
                    self.ubicationMap.addAnnotation(annotation)
                }
                if let url = URL(string: randomUsrModel?.results?.first?.picture?.large ?? ""){
                    do {
                        let data = try Data(contentsOf: url)
                        let image = UIImage(data: data)
                        let roundedImage = image?.roundedImage()
                        self.profileImgView.image =  roundedImage
                    } catch {
                        print(error)
                    }
                }
            }
        }
    }
}

public extension UIImage {
    func roundedImage() -> UIImage {
        let imageView: UIImageView = UIImageView(image: self)
        let layer = imageView.layer
        layer.masksToBounds = true
        layer.cornerRadius = imageView.frame.width / 2
        layer.borderWidth = 4
        layer.borderColor = UIColor(red: 15/255, green: 75/255, blue: 15/255, alpha: 1).cgColor
        UIGraphicsBeginImageContext(imageView.bounds.size)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let roundedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return roundedImage!
    }
}
