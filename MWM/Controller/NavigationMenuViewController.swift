//
//  NavigationMenuViewController.swift
//  MWM
//
//  Created by admin on 09/12/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import UIKit
import InteractiveSideMenu

/*
 Menu controller is responsible for creating its content and showing/hiding menu using 'menuContainerViewController' property.
 */
class NavigationMenuViewController: MenuViewController {
    
    let kCellReuseIdentifier = "MenuCell"
    var menuItems: [String] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSideMenu()
        tableView.dataSource = self
        tableView.delegate = self
        // Select the initial row
//        tableView.selectRow(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: UITableViewScrollPosition.none)
    }
    
    func setupSideMenu() {
        
        if let permissionList = LoginUtils.getCurrentUserPermission() {
            
            for list in permissionList.enumerated() {
                menuItems.append(list.element)
            }
        }
    }
}

/*
 Extention of `NavigationMenuViewController` class, implements table view delegates methods.
 */
extension NavigationMenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellReuseIdentifier, for: indexPath)
        cell.textLabel?.text = menuItems[indexPath.row]
        
        return cell
    }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
     func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = Bundle.main.loadNibNamed("SideBarHeaderView", owner: self, options: nil)?[0] as! SideBarHeaderView
        view.userEmailLabel.text = LoginUtils.getCurrentUser()?.email
        view.userNameLabel.text =  LoginUtils.getCurrentUser()?.userName
        return view
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if menuItems[indexPath.row] == "Logout" {
            
            print("Logout")
            
            LogoutGetService.executeRequest { (data) in
                Alert.showAlertWithMessage("Success", message: "User logged out Successfully")
            }
            LoginUtils.setCurrentUserLogin(nil)
            let application = UIApplication.shared.delegate as! AppDelegate
            application.setHomeGuestAsRVC()
            
        } else if menuItems[indexPath.row] == "ChangePassword" {
            print("ChangePassword")
            
            self.performSegue(withIdentifier: "showChangePasswordSegue", sender: self)
            
            
        } else if menuItems[indexPath.row] == "About app" {
            
            print("About app")
        
        } else if menuItems[indexPath.row] == "My Task"{
            
        self.performSegue(withIdentifier: "showMyTask", sender: self)
            
        }
        
        
        
        //        guard let menuContainerViewController = self.menuContainerViewController else {
        //            return
        //        }
        //
        //        menuContainerViewController.selectContentViewController(menuContainerViewController.contentViewControllers[indexPath.row])
        //        menuContainerViewController.hideSideMenu()
    }
}
