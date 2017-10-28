//
//  VerifyOTPModel.swift
//  Demo
//
//  Created by admin on 28/09/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import Gloss

struct VerifyOTPModel {
    
    let contactNo: String
    let otp: String
    
    init( contactNo: String, otp: String) {
        self.contactNo = contactNo
        self.otp = otp
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "mobileNumber" ~~> self.contactNo,
            "otpToken" ~~> self.otp
            ])
    }
}
