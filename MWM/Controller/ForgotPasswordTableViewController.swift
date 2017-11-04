//
//  ForgotPasswordTableViewController.swift
//  Demo
//
//  Created by admin on 07/10/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import UIKit
import  Alamofire

class ForgotPasswordTableViewController: BaseTableViewController {
    
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    var mobileNumber: String?
    var otp: String?
    
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
    
    @IBAction func ChangePasswordTapped(_ sender: Any) {
        
        let newPassword = newPasswordTextField.text!
        let confirmPassword = confirmPasswordTextField.text!
        
        if newPassword.removeAllSpaces().isEmpty {
              Alert.showAlertWithMessage("Error", message: "new password is empty")
            
        } else if confirmPassword.removeAllSpaces().isEmpty {
              Alert.showAlertWithMessage("Error", message: "confirm password is empty")
            
        } else if newPassword != confirmPassword {
              Alert.showAlertWithMessage("Error", message: "password not matched")
            
        } else {
            
            let param = RequestPasswordChangeModel(password: newPassword, mobileNo: mobileNumber!, otpToken: otp!).toJSON()
            
            RequestChangePasswordPostService.executeRequest(param!, completionHandler: { (data) in
                self.navigationController?.popToRootViewController(animated: true)
                Alert.showAlertWithMessage("Success", message: "Password reset Successfully")
            })
        }
    }
}
