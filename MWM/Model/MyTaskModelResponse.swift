//
//  MyTaskModelResponse.swift
//  MWM
//
//  Created by admin on 09/12/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import Gloss
struct MyTaskModelResponse: Gloss.Decodable {
    
    let status: Bool
    let message: String?
    let data: MyTaskModel
    
    init?(json: JSON) {
        guard let  status: Bool  = "status" <~~ json,
            let data: MyTaskModel = "data" <~~ json else { return nil }
        
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
