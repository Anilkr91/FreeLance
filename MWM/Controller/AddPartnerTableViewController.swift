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
    
    let imagePickerController = UIImagePickerController()
    let user = LoginUtils.getCurrentUser()!
    var partnerModel: PartnerModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customerRegionTextField.text = user.region!
        
        getAddress { (address, area) in
            self.addressTextField.text = address
            self.areaTextField.text = area

        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            
            let param = AddPartnerModel(address: address, area: area, brandName: "MBKRestaurant", categoryId: "7", region: user.region!, companyId: user.companyId, customerName: customerName, contactNumber: customerNumber, latitude: "28.587944", longitude: "77.072276", partnerImageUrl: "", partnerName: partnerName, userName: user.userName).toJSON()
            
            
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
    
    func getAddress(handler: @escaping (String, _ locality: String) -> Void) {
        var address: String = ""
        var area: String = ""
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: 28.585100, longitude: 77.071214)
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
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        imagePickerMenu.addAction(cameraAction)
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
            UploadImagePostService.executeRequest(imageData, completionHandler: { (response) in
//                ProgressBarView.hideHUD()
//                if self.imagePicked == 0 {
//                    self.pvc?.visitingCardImageUrl = response.data
//                    self.visitingCardImageView.image = image
//                    
//                } else {
//                    self.pvc?.restaurantImageUrl = response.data
//                    self.restaurantImageView.image = image
//                }
            })
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

