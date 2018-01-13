//
//  EditUserModel.swift
//  MWM
//
//  Created by admin on 06/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import Gloss

struct EditUserModel {
    
    let name: String
    let username: String
    let email: String
    let city: String
    let contact: String
    let permissionGroup: String
    
    init( name: String, username: String, email: String, city: String, contact: String, permissionGroup: String) {
        self.name = name
        self.username = username
        self.email = email
        self.city = city
        self.contact = contact
        self.permissionGroup = permissionGroup
        
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "name" ~~> self.name,
            "userName" ~~> self.username,
            "region" ~~> self.city,
            "email" ~~> self.email,
            "mobileNo" ~~> self.contact,
            "permissionGroup" ~~> self.permissionGroup
            ])
    }
}
