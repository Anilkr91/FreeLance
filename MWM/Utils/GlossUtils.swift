//
//  GlossUtils.swift
//  Demo
//
//  Created by admin on 28/09/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import Gloss
struct GlossResponse<T: Gloss.Decodable>: Glossy {
    
    var status: Bool
    var errorMessage: String?
    var objectData: T?
    var arrayValue: [T]?
//    var arrayData: [T]?
    
    init(status: Bool) {
        self.status = status
    }
    
    init?(json: JSON) {
        guard let status: Bool = "status" <~~ json else { return nil }
        self.status = status
        self.errorMessage = "errorMessage" <~~ json
        self.objectData = "data" <~~ json
        self.arrayValue = "data" <~~ json
//        self.arrayData = "data.content" <~~ json
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "status" ~~> self.status,
            "errorMessage" ~~> self.errorMessage,
            "data" ~~> self.objectData,
            "data" ~~> self.arrayValue
//            "data.content"  ~~> self.arrayData
            ])
    }
    
}
