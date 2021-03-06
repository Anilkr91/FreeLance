 //
//  AppDelegate.swift
//  Demo
//
//  Created by admin on 27/09/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import UIKit
import CoreLocation
import SwiftyUserDefaults
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        validateUserToken()
        checkLoginState()
        setupNavigationAppearance()
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        LocationSingleton.sharedInstance.delegate = self
        LocationSingleton.sharedInstance.startUpdatingLocation()
        
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        validateUserToken()
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }
    
    func setupNavigationAppearance() {
        let navigationbarAppearance = UINavigationBar.appearance()
        navigationbarAppearance.barStyle = .blackTranslucent
        navigationbarAppearance.tintColor = UIColor.white
        navigationbarAppearance.barTintColor = UIColor(hex: "df6a2d")
        //         navigationbarAppearance.shadowImage = nil
        //        navigationbarAppearance.titleTextAttributes = [NSFontAttributeName : UIFont(name: "Javacom", size: 17.0)!]
    }
    func checkLoginState() {
        
        let token = LoginUtils.getCurrentUserLogin()
        if token != nil {
            setHomeUserAsRVC()
        } else {
            setHomeGuestAsRVC()
        }
    }
    
    func setForgotPassword() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: "ChangePasswordTableViewController")
        window?.rootViewController = vc
    }
    
    func setHomeUserAsRVC() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: "HomeViewController")
        window?.rootViewController = vc
    }
    
    func setHomeGuestAsRVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: "InitialViewController") as? UINavigationController
        window?.rootViewController = vc
    }
    
    func validateUserToken() {
        if  Defaults[.isLaunched] == false {
            Defaults[.isLaunched] = true
            
        } else {
            let token = LoginUtils.getCurrentUserLogin()
            if let token = token {
                
                ValidateTokenPostService.executeRequest { (response) in
                LoginUtils.setCurrentUserSession(response.user.sessionId)
                }
            } else { return }
        }
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Demo")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

 
 extension AppDelegate: LocationServiceDelegate {
    
    // MARK: LocationService Delegate
    func tracingLocation(currentLocation: CLLocation) {
        let latitude = currentLocation.coordinate.latitude
        let longitude = currentLocation.coordinate.longitude
        
        print("lat : \(latitude)")
        print( "lon : \(longitude)")
    
    
        if let user = LoginUtils.getCurrentUser() {
            
            let date: Double = NSDate().timeIntervalSince1970.rounded(toPlaces: 0)*1000
            
            let param = ["userFootprints": [FootPrintModel(date: Int(date), latitude: "\(latitude)" , longitude: "\(longitude)", sessionId: user.sessionId!, userId: user.id).toJSON()]]
            
            
            FootPrintPostService.executeRequest(param) { (response) in
                            print(response)
                        }
            
        }
    
    }
        
    
    func tracingLocationDidFailWithError(error: NSError) {
        print("tracing Location Error : \(error.description)")
    }
 }
