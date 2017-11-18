//
//  PartnerModel.swift
//  MWM
//
//  Created by admin on 18/11/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import Gloss

struct PartnerModel: Gloss.Decodable {
    
    let address: String
    let area: String
    let brandName: String
    let categoryId: String
    let city: String
    let companyId: String
    let contactName: String
    let contactNumber: String
    let id: Int
    let latitude: String
    let longitude: String
    let partnerImageUrl: String?
    let partnerName: String
    let userName: String
    let visitingCardImageUrl: String?
    
    
    init?(json: JSON) {
        guard let address: String = "address" <~~ json,
            let area: String = "area" <~~ json,
            let brandName: String = "brandName" <~~ json,
            let categoryId: String = "categoryId" <~~ json,
            let city: String = "city" <~~ json,
            let companyId: String = "companyId" <~~ json,
            let contactName: String = "contactName" <~~ json,
            let contactNumber: String = "contactNumber" <~~ json,
            
            let id: Int = "id" <~~ json,
            let latitude: String = "latitude" <~~ json,
            let longitude: String = "longitude" <~~ json,
            let partnerName: String = "partnerName" <~~ json,
            let userName: String = "userName" <~~ json else { return nil }
        
        self.address = address
        self.area = area
        self.brandName = brandName
        self.categoryId = categoryId
        self.city = city
        self.companyId = companyId
        self.contactName = contactName
        self.contactNumber = contactNumber
        self.id = id
        self.latitude = latitude
        self.longitude = longitude
        self.partnerImageUrl = "partnerImageUrl" <~~ json
        self.partnerName = partnerName
        self.userName = userName
        self.visitingCardImageUrl = "visitingCardImageUrl"
        
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            
            "address" ~~> self.address,
            "area" ~~> self.area,
            "brandName" ~~> self.brandName,
            "categoryId" ~~> self.categoryId,
            "city" ~~> self.city,
            "companyId" ~~> self.companyId,
            "contactName" ~~> self.contactName,
            "contactNumber" ~~> self.contactNumber,
            "id" ~~> self.id,
            "latitude" ~~> self.latitude,
            "longitude" ~~> self.longitude,
            "partnerImageUrl" ~~> self.partnerImageUrl,
            "partnerName" ~~> self.partnerName,
            "userName" ~~> self.userName,
            "visitingCardImageUrl" ~~> self.visitingCardImageUrl
            
            ])
    }
}
