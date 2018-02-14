//
//  ValidateOTPViewController.swift
//  MWM
//
//  Created by admin on 20/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import UIKit

class ValidateOTPViewController: BaseViewController {
    
    @IBOutlet weak var mobileNumberTextField: UITextField!
    @IBOutlet weak var selectCompanyTextField: UITextField!
    
     var companyId: String = ""
    
    lazy var picker = UIPickerView()
    var array: [CompanyModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
         selectCompanyTextField.isHidden = true
        
        // Do any additional setup after loading the view.
    }
    
//    @IBAction func validateTapped(_ sender: Any) {
//        
//        if mobileNumberTextField.text!.removeAllSpaces().isEmpty {
//            Alert.showAlertWithMessage("Error", message: "Email is empty")
//            
//        } else {
//            
//            let param = ["mobileNumber": mobileNumberTextField.text!]
//            ForgotPasswordPostService.executeRequest(param as [String : AnyObject], completionHandler: { (response) in
//                self.performSegue(withIdentifier: "showVerifyOTP", sender: self)
//                Alert.showAlertWithMessage("Success", message: "OTP sent to your registered Mobile Number")
//            })
//        }
//    }
    
    
    @IBAction func validateTapped(_ sender: Any) {
        
        let username = mobileNumberTextField.text!
        
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
                self.performSegue(withIdentifier: "getOTPSegue", sender: self)
                
                
            } else  {
                
                self.selectCompanyTextField.isHidden = false
                self.selectCompanyTextField.inputView = self.picker
                self.picker.delegate = self
                
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "getOTPSegue"  {
            let dvc = segue.destination as! OTPViewController
            dvc.mobile = mobileNumberTextField.text!
            dvc.companyId = companyId
            
        }
    }
}

extension ValidateOTPViewController: UIPickerViewDelegate {
    
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
        self.performSegue(withIdentifier: "getOTPSegue", sender: self)
        return selectCompanyTextField.text = array[row].companyName
    }
}

