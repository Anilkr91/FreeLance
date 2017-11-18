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
    let categoryId: Int
    let city: String
    let companyId: String
    let contactName: String
    let contactNumber: Int
    let createdDate: NSDate
    let id: Int
    let latitude: Double
    let longitude: Double
    let modifiedDate: NSDate
    let partnerImageUrl: NSDate
    let partnerName: String
    let userName: Int
    let visitingCardImageUrl: String
    
    
    init?(json: JSON) {
        guard let address: String = "address" <~~ json,
            let area: String = "area" <~~ json,
            let brandName: String = "brandName" <~~ json,
            let categoryId: Int = "categoryId" <~~ json,
            let city: String = "city" <~~ json,
            let companyId: String = "companyId" <~~ json,
            let contactName: String = "contactName" <~~ json,
            let contactNumber: Int = "contactNumber" <~~ json,
            
            let createdDate: NSDate = "createdDate" <~~ json,
            let id: Int = "id" <~~ json,
            let latitude: Double = "latitude" <~~ json,
            let longitude: Double = "longitude" <~~ json,
            let modifiedDate: NSDate = "modifiedDate" <~~ json,
            let partnerImageUrl: NSDate = "partnerImageUrl" <~~ json,
            let partnerName: String = "partnerName" <~~ json,
            let userName: Int = "userName" <~~ json,
            let visitingCardImageUrl: String = "visitingCardImageUrl" <~~ json else { return nil }
        
        
        self.address = address
        self.area = area
        self.brandName = brandName
        self.categoryId = categoryId
        self.city = city
        self.companyId = companyId
        self.contactName = contactName
        self.contactNumber = contactNumber
        self.createdDate = createdDate
        self.id = id
        self.latitude = latitude
        self.longitude = longitude
        self.modifiedDate = modifiedDate
        self.partnerImageUrl = partnerImageUrl
        self.partnerName = partnerName
        self.userName = userName
        self.visitingCardImageUrl = visitingCardImageUrl
        
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
            
            "createdDate" ~~> self.createdDate,
            "id" ~~> self.id,
            "latitude" ~~> self.latitude,
            "longitude" ~~> self.longitude,
            "modifiedDate" ~~> self.modifiedDate,
            "partnerImageUrl" ~~> self.partnerImageUrl,
            "partnerName" ~~> self.partnerName,
            "userName" ~~> self.userName,
            "visitingCardImageUrl" ~~> self.visitingCardImageUrl
            
            ])
    }
}
