//
//  AddPartnerTableViewController.swift
//  MWM
//
//  Created by admin on 18/11/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import UIKit
import CoreLocation

class AddPartnerTableViewController: BaseTableViewController {
    
    @IBOutlet weak var partnerNameTextField: UITextField!
    @IBOutlet weak var customerRegionTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var areaTextField: UITextField!
    @IBOutlet weak var customerNameTextField: UITextField!
    @IBOutlet weak var customerNumberTextField: UITextField!
    @IBOutlet weak var partnerImageView: UIImageView!
    
    let imagePickerController = UIImagePickerController()
    let user = LoginUtils.getCurrentUser()!
    var partnerModel: PartnerModel?
    var partnerImageUrl: String = ""
    
    var cordinates = CLLocationCoordinate2D()
    lazy var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customerRegionTextField.text = user.region!
        tapGestureRecogniser()
        tableView.separatorStyle = .none
        
        LocationSingleton.sharedInstance.delegate = self
        LocationSingleton.sharedInstance.startUpdatingLocation()
    }
    
    func isAuthorizedtoGetUserLocation() {
        
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse     {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tapGestureRecogniser() {
        
        partnerImageView.isUserInteractionEnabled = true
        
        let tapGestureRecogniser = UITapGestureRecognizer(target: self, action: #selector(AddPartnerTableViewController.displayImageViewTapped(_:)))
        partnerImageView.addGestureRecognizer(tapGestureRecogniser)
    }
    
    func displayImageViewTapped(_ sender: Any) {
        handleImageTapGestureRecognizer()
    }
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        
        let partnerName = partnerNameTextField.text!
        let customerRegion = customerRegionTextField.text!
        let address = addressTextField.text!
        let area = areaTextField.text!
        let customerName = customerNameTextField.text!
        let customerNumber = customerNumberTextField.text!
        
        if partnerName.removeAllSpaces().isEmpty {
            Alert.showAlertWithMessage("Error", message: "Name cannot be empty")
            
        } else if customerRegion.removeAllSpaces().isEmpty {
            Alert.showAlertWithMessage("Error", message: "Mobile cannot be empty")
            
        } else if address.removeAllSpaces().isEmpty {
            
            Alert.showAlertWithMessage("Error", message: "Email cannot be empty")
            
        } else if area.removeAllSpaces().isEmpty {
            
            Alert.showAlertWithMessage("Error", message: "Password cannot be empty")
            
        } else if customerName.removeAllSpaces().isEmpty {
            
            Alert.showAlertWithMessage("Error", message: "Role cannot be empty")
            
        } else if customerNumber.removeAllSpaces().isEmpty {
            
            Alert.showAlertWithMessage("Error", message: "Role cannot be empty")
            
        } else {
            
            let param = AddPartnerModel(address: address, area: area, brandName: "MBKRestaurant", categoryId: "7", region: user.region!, companyId: user.companyId, customerName: customerName, contactNumber: customerNumber, latitude: "28.587944", longitude: "77.072276", partnerImageUrl: partnerImageUrl, partnerName: partnerName, userName: user.userName).toJSON()
            
            print(param)
            
            AddPartnerPostService.executeRequest(param!, completionHandler: { (response) in
                self.partnerModel = response
                self.performSegue(withIdentifier: "showFeedbackSegue", sender: self)
            })
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showFeedbackSegue" {
            let dvc = segue.destination as!  HomeViewController
            dvc.partnerModel = partnerModel
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear
    }
    
    func getAddress(handler: @escaping (String, _ locality: String) -> Void) {
        var address: String = ""
        var area: String = ""
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: cordinates.latitude, longitude: cordinates.longitude)
        //selectedLat and selectedLon are double values set by the app in a previous process
        
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            
            // Place details
            var placeMark: CLPlacemark?
            placeMark = placemarks?[0]
            
            // Address dictionary
            //print(placeMark.addressDictionary ?? "")
            
            // Location name
            if let locationName = placeMark?.addressDictionary?["Name"] as? String {
                address += locationName + ", "
            }
            
            // Street address
            if let street = placeMark?.addressDictionary?["Thoroughfare"] as? String {
                address += street + ", "
            }
            
            // region
            if let region = placeMark?.addressDictionary?["City"] as? String {
                address += region + ", "
            }
            
            // Locality
            if let locality = placeMark?.subLocality {
                area = locality
            }
            
            // Zip code
            if let zip = placeMark?.addressDictionary?["ZIP"] as? String {
                address += zip + ", "
            }
            
            // Country
            if let country = placeMark?.addressDictionary?["Country"] as? String {
                address += country
            }
            print(address)
            // Passing address back
            handler(address, area)
        })
    }
}

extension AddPartnerTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func handleImageTapGestureRecognizer() {
        
        let imagePickerMenu = UIAlertController(title: "upload", message: nil, preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Take photo", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            
            self.imagePickerController.sourceType = .camera
            self.imagePickerController.cameraDevice = .rear
            self.presentImagePickerController()
        })
        
        let galleryAction = UIAlertAction(title: "Choose from Library", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.imagePickerController.sourceType = .photoLibrary
            self.presentImagePickerController()
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        imagePickerMenu.addAction(cameraAction)
        imagePickerMenu.addAction(galleryAction)
        imagePickerMenu.addAction(cancelAction)
        self.present(imagePickerMenu, animated: true, completion: nil)
    }
    
    func presentImagePickerController() {
        self.imagePickerController.delegate = self
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        ProgressBarView.showHUD()
        
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.imagePickerController.dismiss(animated: true, completion: nil)
        
        if let imageData = image?.jpeg(.medium) {
            UploadPartnerImagePostService.executeRequest(imageData, completionHandler: { (response) in
                ProgressBarView.hideHUD()
                self.partnerImageView.image = image
                self.partnerImageUrl = response.data
            })
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

//extension AddPartnerTableViewController: CLLocationManagerDelegate{
//
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        print("Did location updates is called")
//        //store the user location here to firebase or somewhere
//
//        lat = locations[0].coordinate.latitude
//        long = locations[0].coordinate.longitude
//
//        getAddress { (address, area) in
//            self.addressTextField.text = address
//            self.areaTextField.text = area
//        }
//    }
//}

//extension AddPartnerTableViewController: CLLocationManagerDelegate {
//
//    func setupCoreLocation() {
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//    }
//
//    func startLocationUpdates() {
//        switch CLLocationManager.authorizationStatus() {
//        case .notDetermined:
//            locationManager.requestWhenInUseAuthorization()
//            break
//
//        case .authorizedWhenInUse:
//            locationManager.delegate = self
//            locationManager.startUpdatingLocation()
//            break
//
//        case .denied:
//            print(".Denied")
//            break
//
//        default:
//            print("Undefined authorization status")
//            break
//        }
//    }
//
//    func stopLocationUpdates() {
//        locationManager.delegate = nil
//        locationManager.stopUpdatingLocation()
//    }
//
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        startLocationUpdates()
//    }
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let userLocation = locations[0] as CLLocation
//
//        locationManager.stopUpdatingLocation()
//
//        cordinates = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude,longitude: userLocation.coordinate.longitude)
//        getAddress { (address, area) in
//                        self.addressTextField.text = address
//                        self.areaTextField.text = area
//                    }
//    }
//}

extension AddPartnerTableViewController: LocationServiceDelegate {
    
    // MARK: LocationService Delegate
    func tracingLocation(currentLocation: CLLocation) {
        let lat = currentLocation.coordinate.latitude
        let lon = currentLocation.coordinate.longitude
        
        print("lat : \(lat)")
        print( "lon : \(lon)")
        cordinates = CLLocationCoordinate2D(latitude: currentLocation.coordinate.latitude,longitude: currentLocation.coordinate.longitude)
        LocationSingleton.sharedInstance.stopUpdatingLocation()
        getAddress { (address, area) in
            self.addressTextField.text = address
            self.areaTextField.text = area
        }
    }
    
    func tracingLocationDidFailWithError(error: NSError) {
        print("tracing Location Error : \(error.description)")
    }
}
