//
//  EditUserTableViewController.swift
//  MWM
//
//  Created by admin on 06/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//


import UIKit

class EditUserTableViewController: BaseTableViewController {
    
    var userModel: UserListResponseModel?
    let user = LoginUtils.getCurrentUser()!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var cityTextfield: UITextField!
    @IBOutlet weak var contactNumberTextField: UITextField!
    @IBOutlet weak var selectPermissionTextField: UITextField!
    
    var array:[String] = []
    
    lazy var picker = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectPermissionTextField.inputView = picker
        picker.delegate = self
        prefillsetupView()
        getCustomRoles()
    }
    
    func prefillsetupView() {
        
        if let user = userModel {
            
            nameTextField.text = user.name
            userNameTextField.text = user.userName
            emailTextField.text = user.email
            cityTextfield.text = user.region
            contactNumberTextField.text = user.mobileNo
            selectPermissionTextField.text = user.permissionGroup
        }
    }
    
    func getCustomRoles() {
        
        let param = ["companyId": user.companyId]
        CustomRoleGetService.executeRequest(param) { (response) in
            print(response.data)
            self.array = response.data
            self.picker.reloadAllComponents()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
        
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.selectionStyle = .none
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
        
        let name = nameTextField.text!
        let userName = userNameTextField.text!
        let email = emailTextField.text!
        let region = cityTextfield.text!
        let contact = contactNumberTextField.text!
        let permission = selectPermissionTextField.text!
        
        
        let param = EditUserModel(name: name, username: userName, email: email, city: region, contact: contact, permissionGroup: permission).toJSON()
        
        editUser(param: param!)
        
    }
    
    func editUser(param: [String: Any]) {
        
        EditUserPutService.executeRequest(param) { (response) in
             print(response)
        }
    }
}

extension EditUserTableViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return array.count
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return array[row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        return selectPermissionTextField.text = array[row]
        
    }
}
