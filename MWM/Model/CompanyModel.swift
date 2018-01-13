//
//  CompanyModel.swift
//  MWM
//
//  Created by admin on 13/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import Gloss

struct CompanyModel: Gloss.Decodable {
    
    let companyId: String
    let companyName: String
    let userName: String
    
    init?(json: JSON) {
        guard let companyId: String = "companyId" <~~ json,
            let companyName: String = "companyName" <~~ json,
            let userName: String  = "userName" <~~ json else { return nil }
        
        self.companyId = companyId
        self.companyName = companyName
        self.userName = userName
        
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "companyId" ~~> self.companyId,
            "companyName" ~~> self.companyName,
            "userName" ~~> self.userName
            ])
    }
}
