//
//  LoginModel.swift
//  Demo
//
//  Created by admin on 28/09/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import Gloss

struct LoginModel {
    
    let username: String
    let password: String
    
    init( username: String, password: String /*companyId: String*/) {
        self.username = username
        self.password = password
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "userName" ~~> self.username,
            "password" ~~> self.password
            ])
    }
}
