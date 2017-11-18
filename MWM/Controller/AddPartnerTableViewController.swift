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
    
    
    let user = LoginUtils.getCurrentUser()!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customerRegionTextField.text = user.city!
        
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
            
            let param = AddPartnerModel(address: address, area: area, brandName: "MBKRestaurant", categoryId: "7", city: user.city!, companyId: user.companyId, customerName: customerName, contactNumber: customerNumber, latitude: "28.587944", longitude: "77.072276", partnerImageUrl: "", partnerName: partnerName, userName: user.userName).toJSON()
            
            
            AddPartnerPostService.executeRequest(param!, completionHandler: { (response) in
                print(response)
            })
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
            
            // City
            if let city = placeMark?.addressDictionary?["City"] as? String {
                address += city + ", "
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
