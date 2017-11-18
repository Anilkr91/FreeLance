//
//  FootPrintModelArray.swift
//  MWM
//
//  Created by admin on 15/11/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import Gloss

struct FootPrintModelArray {
    
    let userFootprints: [FootPrintModel]
    
    init(userFootprints: [FootPrintModel]) {
        
        self.userFootprints = userFootprints
    }
    
    //    init?(json: JSON) {
    //
    //        guard  let latitude: Double = "latitude" <~~ json,
    //            let longitude: Double = "longitude" <~~ json,
    //            let sessionId: String = "sessionId" <~~ json,
    //            let userId: Int = "userId" <~~ json else { return nil }
    //
    //        self.latitude = latitude
    //        self.longitude = longitude
    //        self.sessionId = sessionId
    //        self.userId = userId
    //    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "userFootprints" ~~> self.userFootprints
            ])
    }
}
