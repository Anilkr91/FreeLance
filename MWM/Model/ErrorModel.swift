//
//  ErrorModel.swift
//  Demo
//
//  Created by admin on 30/09/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import Gloss

struct ErrorModel: Gloss.Decodable {
    
    let status: Bool
    let errorMessage: String
    
    init?(json: JSON) {
        guard let  status: Bool  = "status" <~~ json,
            let errorMessage: String = "errorMessage" <~~ json else { return nil }
        
        self.status = status
        self.errorMessage = errorMessage
    }

    func toJSON() -> JSON? {
        return jsonify([
            "status" ~~> self.status,
            "errorMessage" ~~> self.errorMessage
            ])
    }
}
