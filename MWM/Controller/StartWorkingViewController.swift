//
//  StartWorkingViewController.swift
//  MWM
//
//  Created by admin on 04/11/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import UIKit
import CoreLocation
import SwiftyUserDefaults
import Alamofire

class StartWorkingViewController: BaseViewController {
    
    @IBOutlet weak var startWorkingButton: UIButton!
    @IBOutlet weak var newEntryButton: UIButton!
    
    var cordinates = CLLocationCoordinate2D()
    lazy var locationManager = CLLocationManager()
    
    let user = LoginUtils.getCurrentUser()
    var footPrints = [FootPrintModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setButtonTitle()
//        setupBarButton()
        startWorkingButton.addTarget(self, action: #selector(StartWorkingViewController.startWorking), for: .touchUpInside)
        newEntryButton.addTarget(self, action: #selector(StartWorkingViewController.startNewEntry), for: .touchUpInside)
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
            startWork()
            
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

        let param = ["userFootprints": [FootPrintModel(/*date: "",*/ latitude: "\(28.585100)" , longitude: "\(77.071214)", sessionId: sessionId, userId: userId).toJSON()]]
        print(param)
        
        for (k,v) in param.enumerated() {
            print(k)
            print(v.key)
        }
        FootPrintPostService.executeRequest(param) { (response) in
            print(response)
        }
    }
}

//extension StartWorkingViewController {
//    
//    func setupBarButton() {
//        let barButton = UIBarButtonItem()
//        barButton.tintColor = UIColor.darkGray
//        barButton.image = UIImage(named: "SettingIcon")
//        barButton.target = self
//        barButton.action = #selector(self.logout(_:))
//        self.navigationItem.rightBarButtonItem = barButton
//    }
//    
//    func logout(_ sender: Any) {
//        
//        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
//        // create an action
//        let firstAction: UIAlertAction = UIAlertAction(title: "Logout", style: .default) { action -> Void in
//            
//            LogoutGetService.executeRequest { (data) in
//                Alert.showAlertWithMessage("Success", message: "User logged out Successfully")
//            }
//            LoginUtils.setCurrentUserLogin(nil)
//            let application = UIApplication.shared.delegate as! AppDelegate
//            application.setHomeGuestAsRVC()
//        }
//        
//        let secondAction: UIAlertAction = UIAlertAction(title: "Change Password", style: .default) { action -> Void in
//            self.performSegue(withIdentifier: "showChangePasswordSegue", sender: self)
//        }
//        
//        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in }
//        // add actions
//        actionSheetController.addAction(firstAction)
//        actionSheetController.addAction(secondAction)
//        actionSheetController.addAction(cancelAction)
//        
//        // present an actionSheet...
//        actionSheetController.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
//        present(actionSheetController, animated: true, completion: nil)
//    }
//}


extension StartWorkingViewController: CLLocationManagerDelegate {
    
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
