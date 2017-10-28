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
    
    let accountManagerId: Int
    let active: Bool
    let city: String
    let companyId: String
    let email: String
    let featureList: String
    let id: Int
    let latitude: Double
    let longitude: Double
    let mobileNo: String
    let name: String
    let profilePicture: String?
    let sessionActive: Bool
    let sessionId: Int?
    let userName: String
    let userRole: String
    
    init?(json: JSON) {
        guard let accountManagerId: Int = "accountManagerId" <~~ json,
            let active: Bool = "active" <~~ json,
            let city: String  = "city" <~~ json,
            let companyId: String  = "companyId" <~~ json,
            let email: String  = "email" <~~ json,
            let featureList: String  = "featureList" <~~ json,
            let id: Int  = "id" <~~ json,
            let latitude: Double  = "latitude" <~~ json,
            let longitude: Double  = "longitude" <~~ json,
            let mobileNo: String  = "mobileNo" <~~ json,
            let name: String  = "name" <~~ json,
            let sessionActive: Bool  = "sessionActive" <~~ json,
            let userName: String  = "userName" <~~ json,
            let userRole: String  = "userRole" <~~ json else { return nil }
        
        self.accountManagerId = accountManagerId
        self.active = active
        self.city = city
        self.companyId = companyId
        self.email = email
        self.featureList = featureList
        self.id = id
        self.latitude = latitude
        self.longitude = longitude
        self.mobileNo = mobileNo
        self.name = name
        self.profilePicture = "profilePicture" <~~ json
        self.sessionActive = sessionActive
        self.sessionId = "sessionId" <~~ json
        self.userName = userName
        self.userRole = userRole
        
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            
            "accountManagerId" ~~> self.accountManagerId,
            "active" ~~> self.active,
            "city" ~~> self.city,
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
