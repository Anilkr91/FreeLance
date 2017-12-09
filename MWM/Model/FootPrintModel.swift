//
//  FootPrintModel.swift
//  MWM
//
//  Created by admin on 12/11/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import Gloss

struct FootPrintModel {
    
//    let date: NSDate
    let latitude: String
    let longitude: String
    let sessionId: Int
    let userId: Int
    
    init(/*date: NSDate,*/ latitude: String, longitude: String, sessionId: Int, userId: Int) {
       
//        self.date = date
        self.latitude = latitude
        self.longitude = longitude
        self.sessionId = sessionId
        self.userId = userId
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            
//            "createdDate" ~~> self.date,
            "latitude" ~~> self.latitude,
            "longitude" ~~> self.longitude,
            "sessionId" ~~> self.sessionId,
            "userId" ~~> self.userId,
            ])
    }
}
