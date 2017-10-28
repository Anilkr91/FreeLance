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
    let data: Bool
    
    init?(json: JSON) {
        guard let  status: Bool  = "status" <~~ json,
            let data: Bool = "data" <~~ json else { return nil }
        
        self.status = status
        self.data = data
        self.message = "errorMessage" <~~ json
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "status" ~~> self.status,
            "data" ~~> self.data,
            "errorMessage" ~~> self.message
            ])
    }
}
