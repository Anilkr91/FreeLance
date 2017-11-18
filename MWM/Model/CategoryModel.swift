//
//  CategoryModel.swift
//  MWM
//
//  Created by admin on 18/11/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import Gloss

struct CategoryModel: Gloss.Decodable {
    
    let companyId: String
    let id: Int
    let name: String
    
    init?(json: JSON) {
        guard let companyId: String = "companyId" <~~ json,
            let id: Int = "id" <~~ json,
            let name: String  = "name" <~~ json else { return nil }
        
        self.companyId = companyId
        self.id = id
        self.name = name
        
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "companyId" ~~> self.companyId,
            "id" ~~> self.id,
            "name" ~~> self.name
            ])
    }
}
