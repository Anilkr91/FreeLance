//
//  AddPartnerModel.swift
//  MWM
//
//  Created by admin on 18/11/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import Gloss

struct AddPartnerModel {
    
    let address: String
    let area: String
    let brandName: String
    let categoryId: String
    let region: String
    let companyId: String
    let customerName: String
    let contactNumber: String
    let latitude: String
    let longitude: String
    let partnerImageUrl: String
    let partnerName: String
    let userName: String
    
    init (address: String, area: String, brandName: String, categoryId: String, region: String, companyId: String, customerName: String, contactNumber: String, latitude: String, longitude: String, partnerImageUrl: String, partnerName: String, userName: String) {
        
        
        self.address = address
        self.area = area
        self.brandName = brandName
        self.categoryId = categoryId
        self.region = region
        self.companyId = companyId
        self.customerName = customerName
        self.contactNumber = contactNumber
        self.latitude = latitude
        self.longitude = longitude
        self.partnerImageUrl = partnerImageUrl
        self.partnerName = partnerName
        self.userName = userName
        
    }
    
    
//    init?(json: JSON) {
//        
//        guard let address: String = "address" <~~ json,
//            let area: String = "area" <~~ json,
//            let brandName: String = "brandName" <~~ json,
//            let categoryId: String = "categoryId" <~~ json,
//            let region: String = "region" <~~ json,
//            let companyId: String = "companyId" <~~ json,
//            let customerName: String = "contactName" <~~ json,
//            let contactNumber: String = "contactNumber" <~~ json,
//            let latitude: String = "latitude" <~~ json,
//            let longitude: String = "longitude" <~~ json,
//            let partnerImageUrl: String = "partnerImageUrl" <~~ json,
//            let partnerName: String = "partnerName" <~~ json,
//            let userName: String = "userName" <~~ json else { return nil }
//        
//        self.address = address
//        self.area = area
//        self.brandName = brandName
//        self.categoryId = categoryId
//        self.region = region
//        self.companyId = companyId
//        self.customerName = customerName
//        self.contactNumber = contactNumber
//        self.latitude = latitude
//        self.longitude = longitude
//        self.partnerImageUrl = partnerImageUrl
//        self.partnerName = partnerName
//        self.userName = userName
//        
//    }
    
    func toJSON() -> JSON? {
        return jsonify([
            
            "address" ~~> self.address,
            "area" ~~> self.area,
            "brandName" ~~> self.brandName,
            "categoryId" ~~> self.categoryId,
            "region" ~~> self.region,
            "companyId" ~~> self.companyId,
            "contactName" ~~> self.customerName,
            "contactNumber" ~~> self.contactNumber,
            "latitude" ~~> self.latitude,
            "longitude" ~~> self.longitude,
            "partnerImageUrl" ~~> self.partnerImageUrl,
            "partnerName" ~~> self.partnerName,
            "userName" ~~> self.userName,
            
            ])
    }
}
