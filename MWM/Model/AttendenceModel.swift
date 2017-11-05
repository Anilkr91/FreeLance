//
//  AttendenceModel.swift
//  MWM
//
//  Created by admin on 04/11/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import Gloss

struct AttendenceModel: Gloss.Decodable {
    
    let accountManagerId: Int
    let companyId: String
    let defaulter: Bool
    let id: Int
    let userId: Int
    let userName: String
    
    
    init?(json: JSON) {
        
        guard  let accountManagerId: Int = "accountManagerId" <~~ json,
            let companyId: String = "companyId" <~~ json,
            let defaulter: Bool = "defaulter" <~~ json,
            let id: Int = "id" <~~ json,
            let userId: Int = "userId" <~~ json,
            let userName: String = "userName" <~~ json else { return nil }
        
        self.accountManagerId = accountManagerId
        self.companyId = companyId
        self.defaulter = defaulter
        self.id = id
        self.userId = userId
        self.userName = userName
    }
    
    
    func toJSON() -> JSON? {
        return jsonify([

            "accountManagerId" ~~> self.accountManagerId,
            "companyId" ~~> self.companyId,
            "defaulter" ~~> self.defaulter,
            "id" ~~> self.id,
            "userId" ~~> self.userId,
            "userName" ~~> self.userName
            ])
    }
}
