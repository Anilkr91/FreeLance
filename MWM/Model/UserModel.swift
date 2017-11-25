//
//  UserModel.swift
//  Demo
//
//  Created by admin on 28/09/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import Foundation
import Gloss

struct UserModel: Gloss.Decodable {
    
    let accountManagerId: Int?
    let active: Bool
    let region: String?
    let companyId: String
    let email: String?
    let featureList: String?
    let id: Int
    let latitude: Double?
    let longitude: Double?
    let mobileNo: String?
    let name: String
    let profilePicture: String?
    let sessionActive: Bool?
    let sessionId: Int?
    let userName: String
    let userRole: String
    
    init?(json: JSON) {
        guard let active: Bool = "active" <~~ json,
            let companyId: String  = "companyId" <~~ json,
            let id: Int  = "id" <~~ json,
            let name: String  = "name" <~~ json,
            let userName: String  = "userName" <~~ json,
            let userRole: String  = "userRole" <~~ json else { return nil }
        
        self.accountManagerId = "accountManagerId" <~~ json
        self.active = active
        self.region = "region" <~~ json
        self.companyId = companyId
        self.email = "email" <~~ json
        self.featureList = "featureList" <~~ json
        self.id = id
        self.latitude = "latitude" <~~ json
        self.longitude = "longitude" <~~ json
        self.mobileNo = "mobileNo" <~~ json
        self.name = name
        self.profilePicture = "profilePicture" <~~ json
        self.sessionActive = "sessionActive" <~~ json
        self.sessionId = "sessionId" <~~ json
        self.userName = userName
        self.userRole = userRole
        
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            
            "accountManagerId" ~~> self.accountManagerId,
            "active" ~~> self.active,
            "region" ~~> self.region,
            "companyId" ~~> self.companyId,
            "email" ~~> self.email,
            "featureList" ~~> self.featureList,
            "id" ~~> self.id,
            "latitude" ~~> self.latitude,
            "longitude" ~~> self.longitude,
            "mobileNo" ~~> self.mobileNo,
            "name" ~~> self.name,
            "profilePicture" ~~> self.profilePicture,
            "sessionActive" ~~> self.sessionActive,
            "sessionId" ~~> self.sessionId,
            "userName" ~~> self.userName,
            "userRole" ~~> self.userRole,
            
            ])
    }
}
