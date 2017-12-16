//
//  UserListResponseArrayModel.swift
//  MWM
//
//  Created by admin on 16/12/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import Gloss

struct UserListResponseArrayModel: Gloss.Decodable{
    
    let status: Bool
    let totalElements: Int
    let data: [UserListResponseModel]
    
    
    init?(json: JSON) {
        
        guard  let status: Bool = "status" <~~ json,
            let totalElements: Int = "data.totalElements" <~~ json,
            let data: [UserListResponseModel] = "data.content" <~~ json else { return nil }
        
        self.status = status
        self.totalElements = totalElements
        self.data = data
        
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            
            "status" ~~> self.status,
            "data.totalElements" ~~> totalElements,
            "data.content" ~~> self.data
            
            ])
    }
}
