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
    
    // mbkrestaurant
    let brandName: String
    let categoryId: String
    let city: String
    let companyId: String
    let customerName: String
    let contactNumber: String
    let latitude: String
    let longitude: String
    let partnerImageUrl: String
    let partnerName: String
    let userName: String
    
    init (address: String, area: String, brandName: String, categoryId: String, city: String, companyId: String, customerName: String, contactNumber: String, latitude: String, longitude: String, partnerImageUrl: String, partnerName: String, userName: String) {
    
    
    self.address = address
    self.area = area
    
    // mbkrestaurant
    self.brandName = brandName
    self.categoryId = categoryId
    self.city = city
    self.companyId = companyId
    self.customerName = customerName
    self.contactNumber = contactNumber
    self.latitude = latitude
    self.longitude = longitude
    self.partnerImageUrl = partnerImageUrl
    self.partnerName = partnerName
    self.userName = userName
        
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            
            "brandName" ~~> self.brandName,
            "categoryId" ~~> self.categoryId,
            "city" ~~> self.city,
            "companyId" ~~> self.companyId,
            "customerName" ~~> self.customerName,
            "contactNumber" ~~> self.contactNumber,
            "latitude" ~~> self.latitude,
            "longitude" ~~> self.longitude,
            "partnerImageUrl" ~~> self.partnerImageUrl,
            "partnerName" ~~> self.partnerName,
            "userName" ~~> self.userName,
    
            ])
    }
}
