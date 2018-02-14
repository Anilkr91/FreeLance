//
//  LoginTableViewController.swift
//  Demo
//
//  Created by admin on 28/09/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import UIKit
import  Alamofire

class LoginTableViewController: BaseTableViewController {
    
    var userName: String?
    var companyId: String?
    
    let allPermission = [
        
        "AttendanceWithCamera","AttendanceWithoutCamera","Footprint","ViewAttendance","ManageUser","UpdateProfile",
        "ViewAllUser","ViewRegionUser","ManageOwnTask","ManageAllTask","MBKAutoMobileEmployee","MBKAutoMobileManager",
        "MBKRestaurantEmployee","MBKRestaurantManager","MBKHealthcareEmployee","MBKHealthcareManager","MBKPetrolPumpEmployee",
        "MBKPetrolPumpManager","ManageCompany","UpdateCompany","OfflineSubmit","EditRole","ManagePartner","ViewAllPartner"
        
    ]
    
    @IBOutlet weak var passwordTextField: UITextField!
    let imagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackgroundImage()
        tableView.separatorStyle = .none
    }
    
    func setupBackgroundImage() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "bg")
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.view.backgroundColor = UIColor(hex: "df6a2d")
        self.tableView.backgroundView = backgroundImage
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            return 8
        } else {
            return 2
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            return 8
        } else {
            return 2
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            return 56
        } else {
            return 44
        }
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear
    }
    
    @IBAction func LoginTapped(_ sender: Any) {
        
        let password = passwordTextField.text!
        
        if password.removeAllSpaces().isEmpty {
            Alert.showAlertWithMessage("Error", message: "Password is empty")
            
        } else {
            loginApiService(userName: userName!, password: password)
        }
    }
    
    func loginApiService(userName: String, password: String) {
        let param = LoginModel(username: userName, password: password, companyId: companyId!).toJSON()
        
        LoginPostService.executeRequest(param!, completionHandler: { (response) in
            LoginUtils.setCurrentUserLogin(response)
            self.createPermissionArray(permisssionList: response.permissionList)
            LoginUtils.setCurrentUserSession(response.user.sessionId)
            let application = UIApplication.shared.delegate as! AppDelegate
            application.setHomeUserAsRVC()
        })
    }
    
    
        func createPermissionArray(permisssionList: [String]) {
    
            var sideMenuArray: [String] = []
            for permission in permisssionList.enumerated(){
    
                if permission.element == "MBKAutoMobileEmployee" || permission.element == "MBKRestaurantEmployee" || permission.element == "MBKHealthcareEmployee" || permission.element == "MBKPetrolPumpEmployee" {
    
                    sideMenuArray.append("Dashboard")
                    sideMenuArray.append("Today's Summary")
                }
    
                if permission.element == "MBKHealthcareManager" || permission.element == "MBKPetrolPumpManager" || permission.element == "MBKRestaurantManager" || permission.element == "MBKAutoMobileManager" {
                    sideMenuArray.append("Admin Panel")
                }
    
                if permission.element == "ManageOwnTask" || permission.element == "ManageAllTask" {
                    sideMenuArray.append("My Task")
                }
    
                if permission.element == "ManageUser" || permission.element == "ViewAllUser" || permission.element == "ViewRegionUser" {
                    sideMenuArray.append("Users")
                }
    
                if permission.element == "ViewAttendance" {
    
                    if permission.element == "UpdateCompany" {
                        sideMenuArray.append("My Attendence")
                    }
                }
    
                if permission.element == "MBKPetrolPumpManager" || permission.element == "MBKPetrolPumpEmployee"  && permission.element != "UpdateCompany"{
    
//                    if  {
                        sideMenuArray.append("MBKPetrolPump")
//                    }
                }
    
                if permission.element == "MBKAutoMobileEmployee" || permission.element == "MBKAutoMobileManager" {
    
                    if permission.element != "UpdateCompany" {
                        sideMenuArray.append("MBKAutoMobile")
                    }
                }
    
                if permission.element == "MBKHealthcareEmployee" || permission.element == "MBKHealthcareManager" {
    
                    if permission.element != "UpdateCompany" {
                        sideMenuArray.append("MBKHealthCare")
                    }
                }
    
                if permission.element == "MBKRestaurantEmployee" || permission.element == "MBKRestaurantManager" {
    
                    if permission.element != "UpdateCompany" {
                        sideMenuArray.append("MBKRestaurant")
                    }
                }
    
                sideMenuArray.append("ChangePassword")
                sideMenuArray.append("Logout")
                sideMenuArray.append("About app")
//                sideMenuArray.append("Users")
            }
    
            LoginUtils.setCurrentUserPermission(Array(Set(sideMenuArray)))
        }
    
    
    
//    func createPermissionArray(permisssionList: [String]) {
//        
//        var sideMenuArray: [String] = []
//        for permission in permisssionList.enumerated(){
//            
//            for allpermission in allPermission.enumerated() {
//                
//                if permission.element == allpermission.element || permission.element == allpermission.element || permission.element == allpermission.element || permission.element == allpermission.element {
//                    
//                    sideMenuArray.append("Dashboard")
//                    sideMenuArray.append("Today's Summary")
//                }
//                
//                if permission.element == allpermission.element || permission.element == allpermission.element || permission.element == allpermission.element || permission.element == allpermission.element {
//                    sideMenuArray.append("Admin Panel")
//                }
//                
//                if permission.element == allpermission.element || permission.element == allpermission.element {
//                    sideMenuArray.append("My Task")
//                }
//                
//                if permission.element == allpermission.element || permission.element == allpermission.element || permission.element == allpermission.element {
//                    sideMenuArray.append("Users")
//                }
//                
//                if permission.element == allpermission.element {
//                    
//                    if permission.element == "UpdateCompany" {
//                        sideMenuArray.append("My Attendence")
//                    }
//                }
//                
//                if permission.element == allpermission.element || permission.element == allpermission.element {
//                    
//                    if permission.element == "UpdateCompany" {
//                        sideMenuArray.append("MBKPetrolPump")
//                    }
//                }
//                
//                if permission.element == allpermission.element || permission.element == allpermission.element {
//                    
//                    if permission.element != "UpdateCompany" {
//                        sideMenuArray.append("MBKAutoMobile")
//                    }
//                }
//                
//                if permission.element == allpermission.element || permission.element == allpermission.element {
//                    
//                    if permission.element != "UpdateCompany" {
//                        sideMenuArray.append("MBKHealthCare")
//                    }
//                }
//                
//                if permission.element == allpermission.element || permission.element == allpermission.element {
//                    
//                    if permission.element != "UpdateCompany" {
//                        sideMenuArray.append("MBKRestaurant")
//                    }
//                }
//                
//                sideMenuArray.append("ChangePassword")
//                sideMenuArray.append("Logout")
//                sideMenuArray.append("About app")
//                sideMenuArray.append("Users")
//            }
//        }
//        
//        LoginUtils.setCurrentUserPermission(Array(Set(sideMenuArray)))
//    }
    
}

