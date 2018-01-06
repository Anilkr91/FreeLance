//
//  SideMenuOptionsTableViewController.swift
//  MWM
//
//  Created by admin on 06/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import UIKit

class SideMenuOptionsTableViewController: UITableViewController {
    
    var array:[String] = []
    var selectedMenuItem : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        array = LoginUtils.getCurrentUserPermission()!
        print(array)
    
        tableView.contentInset = UIEdgeInsetsMake(64.0, 0, 0, 0) //
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.clear
        tableView.scrollsToTop = false
        
        // Preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return array.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = array[indexPath.row]
        
        // Configure the cell...
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("did select row: \(indexPath.row)")
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var dvc: UIViewController
        
        if array[indexPath.row] == "Logout" {
            
            print("Logout")
            
            LogoutGetService.executeRequest { (data) in
                Alert.showAlertWithMessage("Success", message: "User logged out Successfully")
            }
            LoginUtils.setCurrentUserLogin(nil)
            let application = UIApplication.shared.delegate as! AppDelegate
            application.setHomeGuestAsRVC()
            
        } else if array[indexPath.row] == "ChangePassword" {
            print("ChangePassword")
            
            dvc = storyboard.instantiateViewController(withIdentifier: "ChangePasswordTableViewController")
            sideMenuController()?.setContentViewController(dvc)
//            self.performSegue(withIdentifier: "showChangePasswordSegue", sender: self)
            
            
        } else if array[indexPath.row] == "About app" {
            
            print("About app")
            
        } else if array[indexPath.row] == "My Task"{
        
            dvc = storyboard.instantiateViewController(withIdentifier: "MyTaskTableViewController")
            sideMenuController()?.setContentViewController(dvc)
//            self.performSegue(withIdentifier: "showMyTask", sender: self)
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
}
