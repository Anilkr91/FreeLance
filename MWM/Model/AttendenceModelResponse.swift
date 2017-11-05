//
//  AttendenceModelResponse.swift
//  MWM
//
//  Created by admin on 04/11/17.
//  Copyright © 2017 Techximum. All rights reserved.
//


import Gloss
struct AttendenceModelResponse: Gloss.Decodable {
    
    let status: Bool
    let message: String?
    let data: AttendenceModel
    
    init?(json: JSON) {
        guard let  status: Bool  = "status" <~~ json,
            let data: AttendenceModel = "data" <~~ json else { return nil }
        
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
