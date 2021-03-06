//
//  IsSuccessModel.swift
//  Demo
//
//  Created by admin on 14/10/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import Gloss
struct IsSuccessModel {
    
    let status: Bool
    let message: String?
    let user: UserModel
    
    init?(json: JSON) {
        guard let  status: Bool  = "status" <~~ json,
            let user: UserModel = "data" <~~ json else { return nil }
        
        self.status = status
        self.user = user
        self.message = "errorMessage" <~~ json
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "status" ~~> self.status,
            "data" ~~> self.user,
            "errorMessage" ~~> self.message
            ])
    }
}
