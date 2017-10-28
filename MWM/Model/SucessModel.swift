//
//  SucessModel.swift
//  Demo
//
//  Created by admin on 01/10/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import Gloss
struct SucessModel {
    
    let status: Bool
    let data: String
    
    init?(json: JSON) {
        guard let  status: Bool  = "status" <~~ json,
            let data: String = "data" <~~ json else { return nil }
        
        self.status = status
        self.data = data
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "status" ~~> self.status,
            "data" ~~> self.data
            ])
    }
}
