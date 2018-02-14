//
//  LocationService+Helper.swift
//  MWM
//
//  Created by admin on 20/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import UIKit
import CoreLocation

protocol LocationServiceDelegate {
    func tracingLocation(currentLocation: CLLocation)
    func tracingLocationDidFailWithError(error: NSError)
}

class LocationSingleton: NSObject,CLLocationManagerDelegate {
    var locationManager: CLLocationManager?
    var lastLocation: CLLocation?
    var delegate: LocationServiceDelegate?
    
    static let sharedInstance:LocationSingleton = {
        let instance = LocationSingleton()
        return instance
    }()
    
    override init() {
        super.init()
        self.locationManager = CLLocationManager()
        
        guard let locationManagers=self.locationManager else {
            return
        }
        
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManagers.requestAlwaysAuthorization()
            locationManagers.requestWhenInUseAuthorization()
        }
        if #available(iOS 9.0, *) {
            //            locationManagers.allowsBackgroundLocationUpdates = true
        } else {
            // Fallback on earlier versions
         }
        locationManagers.desiredAccuracy = kCLLocationAccuracyBest
        locationManagers.pausesLocationUpdatesAutomatically = false
        locationManagers.distanceFilter = 0.1
        locationManagers.delegate = self
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        self.lastLocation = location
        updateLocation(currentLocation: location)
        
    }
    
    @nonobjc func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager?.requestAlwaysAuthorization()
            break
        case .authorizedWhenInUse:
            locationManager?.startUpdatingLocation()
            break
        case .authorizedAlways:
            locationManager?.startUpdatingLocation()
            break
        case .restricted:
            // restricted by e.g. parental controls. User can't enable Location Services
            break
        case .denied:
            // user denied your app access to Location Services, but can grant access from Settings.app
            break
        default:
            break
        }
    }
    
    // Private function
    private func updateLocation(currentLocation: CLLocation){
        
        guard let delegate = self.delegate else {
            return
        }
         delegate.tracingLocation(currentLocation: currentLocation)
        
        if let user = LoginUtils.getCurrentUser() {
            
             let date: Double = NSDate().timeIntervalSince1970.rounded(toPlaces: 0)*1000
            
            let param = ["userFootprints": [FootPrintModel(date: Int(date), latitude: "\(currentLocation.coordinate.latitude)" , longitude: "\(currentLocation.coordinate.longitude)", sessionId: user.sessionId!, userId: user.id).toJSON()]]
            
            FootPrintPostService.executeRequest(param) { (response) in
                print(response)
            }
        }
    }
    
    private func updateLocationDidFailWithError(error: NSError) {
        
        guard let delegate = self.delegate else {
            return
        }
        
        delegate.tracingLocationDidFailWithError(error: error)
    }
    
    func startUpdatingLocation() {
        print("Starting Location Updates")
        self.locationManager?.startUpdatingLocation()
        //        self.locationManager?.startMonitoringSignificantLocationChanges()
    }
    
    func stopUpdatingLocation() {
        print("Stop Location Updates")
        self.locationManager?.stopUpdatingLocation()
    }
    
    func startMonitoringSignificantLocationChanges() {
        self.locationManager?.startMonitoringSignificantLocationChanges()
    }
    
    // #MARK:   get the alarm time from date and time
}
