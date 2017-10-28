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
    
    @IBOutlet weak var userNameTextField: UITextField!
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
        
        let username = userNameTextField.text!
        let password = passwordTextField.text!
        
        if username.removeAllSpaces().isEmpty {
            Alert.showAlertWithMessage("Error", message: "user name is empty")
            
        } else if password.removeAllSpaces().isEmpty {
             Alert.showAlertWithMessage("Error", message: "password is empty")
            
        } else {
            loginApiService(userName: username, password: password)
        }
    }
    
    func loginApiService(userName: String, password: String) {
        let param = LoginModel(username: userName, password: password /* companyId: "mbk002"*/).toJSON()
        
        LoginPostService.executeRequest(param! as [String : AnyObject], completionHandler: { (response) in
           
            LoginUtils.setCurrentUserLogin(response)
            let application = UIApplication.shared.delegate as! AppDelegate
            application.setHomeUserAsRVC()
        })
    }
}
