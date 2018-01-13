//
//  ValidateUserTableViewController.swift
//  MWM
//
//  Created by admin on 13/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import UIKit
import  Alamofire

class ValidateUserTableViewController: BaseTableViewController {
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var selectCompanyTextField: UITextField!
    
    var companyId: String = ""
    
    lazy var picker = UIPickerView()
    var array: [CompanyModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectCompanyTextField.isHidden = true
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
        
        if username.removeAllSpaces().isEmpty {
            Alert.showAlertWithMessage("Error", message: "User name is empty")
            
        } else {
            validateUser(userName: username)
        }
    }
    
    func validateUser(userName: String) {
        ValidateCredentialsGetService.executeRequest(userName) { (response) in
            
            self.array = response
            
            if response.count == 1 {
                self.companyId = self.array[0].companyId
                self.performSegue(withIdentifier: "showLoginSegue", sender: self)
                
                
            } else  {
                
                self.selectCompanyTextField.isHidden = false
                self.selectCompanyTextField.inputView = self.picker
                self.picker.delegate = self
                
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showLoginSegue"  {
            let dvc = segue.destination as! LoginTableViewController
            dvc.userName = userNameTextField.text
            dvc.companyId = companyId
            
        }
    }
}

extension ValidateUserTableViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return array.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return array[row].companyName
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        companyId = array[row].companyId
        self.performSegue(withIdentifier: "showLoginSegue", sender: self)
        return selectCompanyTextField.text = array[row].companyName
    }
}
