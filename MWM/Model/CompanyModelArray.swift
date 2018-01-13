//
//  CompanyModelArray.swift
//  MWM
//
//  Created by admin on 13/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import Gloss

struct CompanyModelArray : Gloss.Decodable{
    
    let status: Bool
    let errorMessage: String?
    let data: [CompanyModel]
    
    
    init?(json: JSON) {
        
        guard  let status: Bool = "status" <~~ json,
            let data: [CompanyModel] = "data" <~~ json else { return nil }
        
        self.status = status
        self.errorMessage = "errorMessage" <~~ json
        self.data = data
        
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            
            "status" ~~> self.status,
            "errorMessage" ~~> errorMessage,
            "data" ~~> self.data
            
            ])
    }
}
