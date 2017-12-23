//
//  HomeViewController.swift
//  Demo
//
//  Created by admin on 28/09/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import UIKit
import CoreLocation

class HomeViewController: BaseViewController {
    
    var cvc: HomeTableViewController!
    var visitingCardImageUrl: String = ""
    var restaurantImageUrl: String = ""
    var partnerModel: PartnerModel?
    
    
    var cordinates = CLLocationCoordinate2D()
    
    lazy var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        cvc = childViewControllers[0] as! HomeTableViewController
        cvc.partnerModel = partnerModel
        cvc.pvc = self
        setupCoreLocation()
        setupBarButton()
    }
    
    func setupBarButton() {
        let barButton = UIBarButtonItem()
        barButton.tintColor = UIColor.darkGray
        barButton.image = UIImage(named: "SettingIcon")
        barButton.target = self
        barButton.action = #selector(self.logout(_:))
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    func logout(_ sender: Any) {
        
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        // create an action
        let firstAction: UIAlertAction = UIAlertAction(title: "Logout", style: .default) { action -> Void in
            
            LogoutGetService.executeRequest { (data) in
            Alert.showAlertWithMessage("Success", message: "User logged out Successfully")
            }
            LoginUtils.setCurrentUserLogin(nil)
            let application = UIApplication.shared.delegate as! AppDelegate
            application.setHomeGuestAsRVC()
        }
        
        let secondAction: UIAlertAction = UIAlertAction(title: "Change Password", style: .default) { action -> Void in
            self.performSegue(withIdentifier: "showChangePasswordSegue", sender: self)
        }
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in }
        // add actions
        actionSheetController.addAction(firstAction)
        actionSheetController.addAction(secondAction)
        actionSheetController.addAction(cancelAction)

        // present an actionSheet...
        actionSheetController.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        present(actionSheetController, animated: true, completion: nil)
    }
    
    @IBAction func submitTapped(_ sender: UIButton) {
        
        let restaurantName =  cvc.restaurantNameTextField.text!
        let contactPerson =  cvc.contactPersonName.text!
        let contactNo = cvc.contactNumber.text!
        let natureOfVisit = cvc.natureOfVisitField.text!
        let statusText = cvc.statusTextfield.text!
        let area = cvc.area.text!
        let onBoard = cvc.onBoardTextfield.text!
        
        if restaurantName.removeAllSpaces().isEmpty {
            Alert.showAlertWithMessage("Error", message: "Restaurant Name Field is Empty")
            
        } else if contactPerson.removeAllSpaces().isEmpty {
            Alert.showAlertWithMessage("Error", message: "ContactPerson Field is Empty")
            
        } else if contactNo.removeAllSpaces().isEmpty {
            Alert.showAlertWithMessage("Error", message: "ContactNo Field is Empty")
            
        } else if natureOfVisit.removeAllSpaces().isEmpty {
            Alert.showAlertWithMessage("Error", message: "NatureOfVisit Field is Empty")
            
        } else if statusText.removeAllSpaces().isEmpty {
            Alert.showAlertWithMessage("Error", message: "Status Field is Empty")
            
        } else if area.removeAllSpaces().isEmpty {
            Alert.showAlertWithMessage("Error", message: "Area Field is Empty")
            
        } else if onBoard.removeAllSpaces().isEmpty {
            Alert.showAlertWithMessage("Error", message: "On Board Field is Empty")
       
        } else if restaurantImageUrl.isEmpty {
            Alert.showAlertWithMessage("Error", message: "Restaurant Image is Empty")
            
        } else {
            
            let user = LoginUtils.getCurrentUser()
            
            let param = SaveRestaurantModel(accountManagerId: "\(user!.accountManagerId!)", area: area, companyId: user!.companyId, onBoardStatus: onBoard, userId: "\(user!.id)", restaurantName: restaurantName, contactPerson: contactPerson, contactNumber: contactNo, natureOfVisit: natureOfVisit, status: statusText, restaurantPic: restaurantImageUrl , visitingCard: visitingCardImageUrl, latitude: cordinates.latitude, longitude: cordinates.longitude).toJSON()
            
            SaveRestaurantPostService.executeRequest(param!, completionHandler: { (data) in
                 self.navigationController?.popToRootViewController(animated: true)
                Alert.showAlertWithMessage("Success", message: "Data is sent successfully")
            })
        }
    }
}

extension HomeViewController: CLLocationManagerDelegate {
    
    func setupCoreLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func startLocationUpdates() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
            
        case .authorizedWhenInUse:
            locationManager.delegate = self
            locationManager.startUpdatingLocation()
            break
            
        case .denied:
            print(".Denied")
            break
            
        default:
            print("Undefined authorization status")
            break
        }
    }
    
    func stopLocationUpdates() {
        locationManager.delegate = nil
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        startLocationUpdates()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = locations[0] as CLLocation
        
        locationManager.stopUpdatingLocation()
        
        cordinates = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude,longitude: userLocation.coordinate.longitude)
    }
}
