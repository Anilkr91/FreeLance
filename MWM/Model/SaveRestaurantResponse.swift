//
//  SaveRestaurantResponse.swift
//  Demo
//
//  Created by admin on 07/10/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import Gloss
struct SaveRestaurantResponse {
    
    let status: Bool
    let errorMessage: String?

    init?(json: JSON) {
        guard let  status: Bool  = "status" <~~ json else { return nil }
        
        self.status = status
        self.errorMessage = "errorMessage" <~~ json
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "status" ~~> self.status,
            "errorMessage" ~~> self.errorMessage
            ])
    }
}
