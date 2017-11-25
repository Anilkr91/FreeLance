//
//  UserModelResponse.swift
//  Demo
//
//  Created by admin on 13/10/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import Foundation
import Gloss

struct UserModelResponse: Gloss.Decodable {

    let permissionList: [String]
    let token: String
    let user: UserModel
    
    init?(json: JSON) {
        guard let permissionList: [String] = "permissionList" <~~ json,
            let token: String = "token" <~~ json,
            let user: UserModel  = "user" <~~ json else { return nil }
        
        self.permissionList = permissionList
        self.token = token
        self.user = user
        
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "permissionList" ~~> self.permissionList,
            "token" ~~> self.token,
            "user" ~~> self.user
            
            ])
    }
}
