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
    
    let featureList: String
    let token: String
    let user: UserModel
    
    init?(json: JSON) {
        guard let featureList: String = "featureList" <~~ json,
            let token: String = "token" <~~ json,
            let user: UserModel  = "user" <~~ json else { return nil }
        
        self.featureList = featureList
        self.token = token
        self.user = user
        
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "featureList" ~~> self.featureList,
            "token" ~~> self.token,
            "user" ~~> self.user
            
            ])
    }
}
