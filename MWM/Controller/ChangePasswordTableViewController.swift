//
//  ChangePasswordTableViewController.swift
//  Demo
//
//  Created by admin on 02/10/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import UIKit
import  Alamofire
import InteractiveSideMenu

class ChangePasswordTableViewController: BaseTableViewController ,SideMenuItemContent{
    
    @IBOutlet weak var oldPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    let imagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackgroundImage()
        setupBarButton()
        tableView.separatorStyle = .none
    }
    
    func setupBarButton() {
        
        let rightBarButton = UIBarButtonItem(title: "Dismiss", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ChangePasswordTableViewController.dismissModally))
        self.navigationItem.leftBarButtonItem = rightBarButton
    }
    
    func dismissModally() {
        
        if let navigationViewController = self.navigationController as? SideMenuItemContent {
            navigationViewController.showSideMenu()
            
        }
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
    
    @IBAction func ChangePasswordTapped(_ sender: Any) {
        
        let oldPassword = oldPasswordTextField.text!
        let newPassword = newPasswordTextField.text!
        let confirmPassword = confirmPasswordTextField.text!
        
        if oldPassword.removeAllSpaces().isEmpty {
            Alert.showAlertWithMessage("Error", message: "Old Password password is empty")
            
        } else if newPassword.removeAllSpaces().isEmpty {
            Alert.showAlertWithMessage("Error", message: "New password is empty")
            
        } else if confirmPassword.removeAllSpaces().isEmpty {
            Alert.showAlertWithMessage("Error", message: "Confirm password is empty")
            
        } else if newPassword != confirmPassword {
            Alert.showAlertWithMessage("Error", message: "Password not matched")
            
        } else {
            let param = ChangePasswordModel(oldPassword: oldPassword, newPassword: newPassword).toJSON()
            ChangePasswordPostService.executeRequest(param! as [String: AnyObject], completionHandler: { (response) in
                self.navigationController?.popToRootViewController(animated: true)
                Alert.showAlertWithMessage("Success", message: "Password Changed Successfully")
            })
        }
    }
}
