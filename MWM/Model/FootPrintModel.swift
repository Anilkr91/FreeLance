//
//  FootPrintModel.swift
//  MWM
//
//  Created by admin on 12/11/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import Gloss

struct FootPrintModel: Gloss.Decodable {
    
    let latitude: Double
    let longitude: Double
    let sessionId: String
    let userId: Int
    
    init(latitude: Double, longitude: Double, sessionId: String, userId: Int) {
       
        self.latitude = latitude
        self.longitude = longitude
        self.sessionId = sessionId
        self.userId = userId
    }
    
    init?(json: JSON) {
        
        guard  let latitude: Double = "latitude" <~~ json,
            let longitude: Double = "longitude" <~~ json,
            let sessionId: String = "sessionId" <~~ json,
            let userId: Int = "userId" <~~ json else { return nil }
        
        self.latitude = latitude
        self.longitude = longitude
        self.sessionId = sessionId
        self.userId = userId
    }
    
    
    func toJSON() -> JSON? {
        return jsonify([
            
            "latitude" ~~> self.latitude,
            "longitude" ~~> self.longitude,
            "sessionId" ~~> self.sessionId,
            "userId" ~~> self.userId,
            ])
    }
}
