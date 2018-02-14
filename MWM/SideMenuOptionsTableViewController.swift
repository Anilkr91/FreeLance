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
//        tableView.backgroundColor = UIColor.clear
        tableView.scrollsToTop = false
    
        // Preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
    }
    
//    func footerLogo() {
//    
////        let frame = CGRect(x: 0, y: 0, width: self.tableView.frame.size.width, height: 100)
////        let footerView = UIView(frame: frame)
////        let button = UIButton(type: .roundedRect)
////        button.frame = CGRect(x: 0, y: 0, width: self.tableView.frame.size.width, height: 100)
////        button.setTitle("Load More", for: .normal)
////        button.backgroundColor =  UIColor.purple
////        button.tintColor =  UIColor.white
////        button.addTarget(self, action: #selector(self.loadMorePartners), for: .touchUpInside)
////        footerView.addSubview(button)
//        self.tableView.tableFooterView = footerView
//        
//        
//        var image: UIImage = UIImage(named: "camomile")!
//        var imageView = UIImageView(image: image)
//        self.view.addSubview(imageView)
//        imageView.frame = CGRect(x: 0, y: 0, width: self.tableView.frame.size.width, height: 100)
//        
//    }
    
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
        cell.selectionStyle = .none
        
        
        if array[indexPath.row] == "Logout" {
          cell.imageView?.image = UIImage(named: "logout")
            
        } else if array[indexPath.row] == "ChangePassword" {
           cell.imageView?.image = UIImage(named: "changepassword")
       
        } else if array[indexPath.row] == "About app" {
            cell.imageView?.image = UIImage(named: "logout")
            
        } else if array[indexPath.row] == "My Task" {
            cell.imageView?.image = UIImage(named: "changepassword")
        
        } else if array[indexPath.row] == "Users" {
            cell.imageView?.image = UIImage(named: "logout")
            
        } else if array[indexPath.row] == "Dashboard" {
            cell.imageView?.image = UIImage(named: "changepassword")
        
        } else if array[indexPath.row] == "MBKRestaurant" {
            cell.imageView?.image = UIImage(named: "changepassword")
        
        } else if array[indexPath.row] == "Today's Summary" {
            cell.imageView?.image = UIImage(named: "changepassword")
        
        }
        
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
            
        } else if array[indexPath.row] == "About app" {
            
            dvc = storyboard.instantiateViewController(withIdentifier: "AboutViewController")
            sideMenuController()?.setContentViewController(dvc)
            
            
        } else if array[indexPath.row] == "My Task"{
        
            dvc = storyboard.instantiateViewController(withIdentifier: "MyTaskOptionsTableViewController")
            sideMenuController()?.setContentViewController(dvc)

        } else if array[indexPath.row] == "Users" {
            
            dvc = storyboard.instantiateViewController(withIdentifier: "MyUsersListTableViewController")
            sideMenuController()?.setContentViewController(dvc)
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
}
