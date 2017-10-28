//
//  RequestPasswordChangeModel.swift
//  Demo
//
//  Created by admin on 14/10/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import Gloss

struct RequestPasswordChangeModel {
    
    let password: String
    let mobileNo: String
    let otpToken: String
    
    init( password: String, mobileNo: String, otpToken: String) {
        
        self.password = password
        self.mobileNo = mobileNo
        self.otpToken = otpToken
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "mobileNo" ~~> self.mobileNo,
            "otpToken" ~~> self.otpToken,
            "password" ~~> self.password
            ])
    }
}
