//
//  StartWorkingViewController.swift
//  MWM
//
//  Created by admin on 04/11/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import UIKit
import ENSwiftSideMenu
import CoreLocation
import SwiftyUserDefaults
import Alamofire

class StartWorkingViewController: BaseViewController {
    
    @IBOutlet weak var startWorkingButton: UIButton!
    @IBOutlet weak var newEntryButton: UIButton!
    
    var cordinates = CLLocationCoordinate2D()
    lazy var locationManager = CLLocationManager()
    let imagePickerController = UIImagePickerController()
    
    let user = LoginUtils.getCurrentUser()
    var footPrints = [FootPrintModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LocationSingleton.sharedInstance.delegate = self
        LocationSingleton.sharedInstance.startUpdatingLocation()
        
        self.sideMenuController()?.sideMenu?.delegate = self
        
        setButtonTitle()
        startWorkingButton.addTarget(self, action: #selector(StartWorkingViewController.startWorking), for: .touchUpInside)
        newEntryButton.addTarget(self, action: #selector(StartWorkingViewController.startNewEntry), for: .touchUpInside)
    }
    
    
    
    @IBAction func toggleSideMenuBtn(_ sender: UIBarButtonItem) {
        
        let session = LoginUtils.getCurrentUserSession()
            
            if session == nil {
                showAlert(title: "Mark Attendence First", message: "")
                
            } else {
               toggleSideMenuView() 
                
            }
    }
    
    func showAlert(title: String, message: String) {
        
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OK = UIAlertAction(title: "OK", style: .default, handler: nil )
        
        alertView.addAction(OK)
        self.present(alertView, animated: true, completion: nil)
    }
    
    func startNewEntry() {
        self.performSegue(withIdentifier: "showPartnerListSegue", sender: self)
        
    }
    
    func setButtonTitle() {
        
        if LoginUtils.getCurrentUserSession() == nil {
            startWorkingButton.setTitle("Start Working", for: .normal)
            newEntryButton.isHidden = true
            
        } else {
            startWorkingButton.setTitle("End Working", for: .normal)
            self.newEntryButton.isHidden = false
        }
    }
    
    func startWorking() {
        
        if LoginUtils.getCurrentUserSession() == nil {
            
            for permission in LoginUtils.getCurrentUserPermissionList()!.enumerated() {
                
                if permission.element == "AttendanceWithCamera" {
                    handleImageTapGestureRecognizer()
                    return
                    
                } else if permission.element == "AttendanceWithoutCamera" {
                    startWork()
                    
                } else {
                    continue
                }
            }
            
        } else {
            endWork()
        }
    }
    
    func endWork() {
        
        let param = ["id": user?.sessionId]
        EndWorkingPostService.executeRequest( param, completionHandler: { (response) in
            LoginUtils.setCurrentUserSession(nil)
            self.startWorkingButton.setTitle("Start Working", for: .normal)
            self.newEntryButton.isHidden = true
        })
    }
    
    func startWithAttendence(attendenceImageUrl: String) {
        
        StartWorkAttendenceWithCameraPostService.executeRequest(attendenceImageUrl) { (response) in
            
            print(response.data)
            // sending user location to server
            self.sendUserFootPrint(sessionId: response.data.id, userId: response.data.userId)
            
            // saving user object to userdefaults
            LoginUtils.setCurrentUserAttendence(response.data)
            LoginUtils.setCurrentUserSession(response.data.id)
            self.startWorkingButton.setTitle("End Working", for: .normal)
            self.newEntryButton.isHidden = false
            
        }
    }
    
    func startWork() {
        
        StartWorkingPostService.executeRequest { (response) in
            
            print(response.data)
            // sending user location to server
            self.sendUserFootPrint(sessionId: response.data.id, userId: response.data.userId)
            
            // saving user object to userdefaults
            LoginUtils.setCurrentUserAttendence(response.data)
            LoginUtils.setCurrentUserSession(response.data.id)
            self.startWorkingButton.setTitle("End Working", for: .normal)
            self.newEntryButton.isHidden = false
            
            // Performing segue to go to feedback screen
            self.performSegue(withIdentifier: "showPartnerListSegue", sender: self)
        }
    }
    
    func sendUserFootPrint(sessionId: Int, userId: Int) {
        
        let date: Double = NSDate().timeIntervalSince1970.rounded(toPlaces: 0)*1000
        
        let param = ["userFootprints": [FootPrintModel(date: Int(date), latitude: "\(cordinates.latitude)" , longitude: "\(cordinates.longitude)", sessionId: sessionId, userId: userId).toJSON()]]
        
        FootPrintPostService.executeRequest(param) { (response) in
            print(response)
        }
    }
}

extension StartWorkingViewController: LocationServiceDelegate {
    
    // MARK: LocationService Delegate
    func tracingLocation(currentLocation: CLLocation) {
        let lat = currentLocation.coordinate.latitude
        let lon = currentLocation.coordinate.longitude
        
        print("lat : \(lat)")
        print( "lon : \(lon)")
        cordinates = CLLocationCoordinate2D(latitude: currentLocation.coordinate.latitude,longitude: currentLocation.coordinate.longitude)
        LocationSingleton.sharedInstance.delegate = nil
        LocationSingleton.sharedInstance.stopUpdatingLocation()
    }
    
    func tracingLocationDidFailWithError(error: NSError) {
        print("tracing Location Error : \(error.description)")
    }
}



//extension StartWorkingViewController: CLLocationManagerDelegate {
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
//    }
//}

extension StartWorkingViewController: ENSideMenuDelegate {
    
    func sideMenuWillOpen() {
        print("sideMenuWillOpen")
    }
    
    func sideMenuWillClose() {
        print("sideMenuWillClose")
    }
    
    func sideMenuShouldOpenSideMenu() -> Bool {
        print("sideMenuShouldOpenSideMenu")
        return true
    }
    
    func sideMenuDidClose() {
        print("sideMenuDidClose")
    }
    
    func sideMenuDidOpen() {
        print("sideMenuDidOpen")
    }
}

extension StartWorkingViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func handleImageTapGestureRecognizer() {
        self.imagePickerController.sourceType = .camera
        self.imagePickerController.cameraDevice = .rear
        self.presentImagePickerController()
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
                ProgressBarView.hideHUD()
                
                self.startWithAttendence(attendenceImageUrl: response.data)
            })
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
