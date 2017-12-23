//
//  VerifyOTPViewController.swift
//  Demo
//
//  Created by admin on 02/10/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import UIKit

class VerifyOTPViewController: BaseViewController {
    
    @IBOutlet weak var retryOTPButton: UIButton!
    @IBOutlet weak var otpTextField: UITextField!
    var mobileNumber: String?
    var timer = Timer()
    var seconds = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer = Timer.scheduledTimer(timeInterval: 1, target:self, selector: #selector(VerifyOTPViewController.updateCounter), userInfo: nil, repeats: true)
        retryOTPButton.setTitle("Retry in \(seconds) seconds", for: .normal)
    }
    
    @IBAction func VerifyOTPTapped(_ sender: Any) {
        
        if otpTextField.text!.removeAllSpaces().isEmpty {
            Alert.showAlertWithMessage("Error", message: "Field is empty")
        } else {
            
            let paramOTP = VerifyOTPModel(contactNo: mobileNumber!, otp: otpTextField.text!).toJSON()
            VerifyOTPPostService.executeRequest(paramOTP! as [String : AnyObject]) { (data) in
                self.timer.invalidate()
                self.retryOTPButton.setTitle("Resend OTP", for: .normal)
                self.performSegue(withIdentifier: "showForgotPasswordSegue", sender: self)
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showForgotPasswordSegue" {
            
            let dvc = segue.destination as! ForgotPasswordTableViewController
            dvc.mobileNumber = mobileNumber
            dvc.otp = otpTextField.text!
        }
    }
    
    func updateCounter() {
        seconds -= 1
        
        retryOTPButton.setTitle("Retry in \(seconds) seconds", for: .normal)
        
        if seconds == 00 {
            timer.invalidate()
            seconds = 60
            retryOTPButton.addTarget(self, action: #selector(VerifyOTPViewController.retryOTP), for: .touchUpInside)
            retryOTPButton.setTitle("Resend OTP", for: .normal)
        } else {
            return
        }
    }
    
    func retryOTP() {
        
        let param = ["mobileNumber": mobileNumber!]
        RetryPostService.executeRequest(param as [String : AnyObject], completionHandler: { (response) in
            Alert.showAlertWithMessage("Sucess", message: response.data!)
            self.timer = Timer.scheduledTimer(timeInterval: 1, target:self, selector: #selector(VerifyOTPViewController.updateCounter), userInfo: nil, repeats: true)
        })
    }
}
