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
    let companyId: String
    
    init( contactNo: String, otp: String,companyId: String ) {
        self.contactNo = contactNo
        self.otp = otp
        self.companyId = companyId
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "mobileNumber" ~~> self.contactNo,
            "otpToken" ~~> self.otp,
            "companyId" ~~> self.companyId
            ])
    }
}
