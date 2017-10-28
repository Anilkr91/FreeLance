//
//  ChangePasswordModel.swift
//  Demo
//
//  Created by admin on 02/10/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import Gloss

struct ChangePasswordModel {

    let oldPassword: String
    let newPassword: String
    
    init(oldPassword: String, newPassword: String) {
        
        self.oldPassword = oldPassword
        self.newPassword = newPassword
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "oldPassword" ~~> self.oldPassword,
            "newPassword" ~~> self.newPassword
            ])
    }
}
