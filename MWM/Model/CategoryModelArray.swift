//
//  CategoryModelArray.swift
//  MWM
//
//  Created by admin on 18/11/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import Gloss

struct CategoryModelArray : Gloss.Decodable{
    
    let status: Bool
    let data: [CategoryModel]
    
    init?(json: JSON) {
        
        guard  let status: Bool = "status" <~~ json,
            let data: [CategoryModel] = "data" <~~ json else { return nil }
        
        self.status = status
        self.data = data
        
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            
            "status" ~~> self.status,
            "data" ~~> self.data
            
            ])
    }
}
