//
//  UserListResponseModel.swift
//  MWM
//
//  Created by admin on 16/12/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import Gloss

struct UserListResponseModel: Gloss.Decodable {

    let active: Bool
    let companyId: String
    let email: String
    let id: Int
    let lastlogin: NSDate?
    let lastSubmissionDate: NSDate?
    let latitude: Double?
    let longitude: Double?
    let mobileNo: String
    let name: String
    let permissionGroup: String
    let profilePicture: String?
    let region: String
    let sessionActive: Bool?
    let sessionId: Int?
    let userName: String
    
    
    init?(json: JSON) {
        
        guard let active: Bool = "active" <~~ json,
            let companyId: String = "companyId" <~~ json,
            let email: String = "email" <~~ json,
            let id: Int =  "id" <~~ json,
            let mobileNo: String = "mobileNo" <~~ json,
            let name: String = "name" <~~ json,
            let permissionGroup: String = "permissionGroup" <~~ json,
            let region: String = "region" <~~ json,
            let userName: String = "userName" <~~ json else { return nil }
        
        self.active = active
        self.companyId = companyId
        self.email = email
        self.id = id
        self.lastlogin = "lastlogin" <~~ json
        self.lastSubmissionDate = "lastSubmissionDate" <~~ json
        self.latitude = "latitude" <~~ json
        self.longitude = "longitude" <~~ json
        self.mobileNo = mobileNo
        self.name =  name
        self.permissionGroup = permissionGroup
        self.profilePicture =  "profilePicture" <~~ json
        self.region =  region
        self.sessionActive =  "sessionActive" <~~ json
        self.sessionId = "sessionId" <~~ json
        self.userName = userName
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "active" ~~> self.active,
            "companyId" ~~> self.companyId,
            "email" ~~> self.email,
            "id" ~~> self.id,
            
            "lastlogin" ~~> self.lastlogin,
            "lastSubmissionDate" ~~> self.lastSubmissionDate,
            "latitude" ~~> self.latitude,
            "longitude" ~~> self.longitude,
            "mobileNo" ~~> self.mobileNo,
            "name" ~~> self.name,
            "permissionGroup" ~~> self.permissionGroup,
            "profilePicture" ~~> self.profilePicture,
            "region" ~~> self.region,
            "sessionActive" ~~> self.sessionActive,
            "sessionId" ~~> self.sessionId,
            "userName" ~~> self.userName
            
            ])
    }
}


