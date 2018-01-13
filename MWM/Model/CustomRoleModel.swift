//
//  CustomRoleModel.swift
//  MWM
//
//  Created by admin on 06/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import Foundation
import Gloss

struct CustomRoleModel: Gloss.Decodable {
    
    let role: String

    init?(json: JSON) {
        guard let role: String = "categoryList"  <~~ json else { return nil }
        
        self.role = role
        
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "categoryList" ~~> self.role
            
            ])
    }
}
