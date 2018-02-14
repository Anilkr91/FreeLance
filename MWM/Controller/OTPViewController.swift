//
//  ForgotPasswordViewController.swift
//  Demo
//
//  Created by admin on 01/10/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import UIKit

class OTPViewController: BaseViewController {
    
    @IBOutlet weak var mobileNumberTextField: UITextField!
     var companyId: String = ""
    var mobile: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mobileNumberTextField.text = mobile
        // Do any additional setup after loading the view.
    }
    
    @IBAction func SendOTPTapped(_ sender: Any) {
        
        if mobileNumberTextField.text!.removeAllSpaces().isEmpty {
             Alert.showAlertWithMessage("Error", message: "Email is empty")
            
        } else {
            
            let param = ["mobileNumber": mobileNumberTextField.text!, "companyId":companyId ]
            ForgotPasswordPostService.executeRequest(param as [String : AnyObject], completionHandler: { (response) in
                self.performSegue(withIdentifier: "showVerifyOTP", sender: self)
                 Alert.showAlertWithMessage("Success", message: "OTP sent to your registered Mobile Number")
            })
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showVerifyOTP" {
            
            let dvc = segue.destination as! VerifyOTPViewController
            dvc.companyId = companyId
            dvc.mobileNumber = mobileNumberTextField.text!
        }
    }
}
