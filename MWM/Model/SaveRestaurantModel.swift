//
//  SaveRestaurantModel.swift
//  Demo
//
//  Created by admin on 30/09/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import Gloss

struct SaveRestaurantModel {
    
    let accountManagerId: String
    let area: String
    let companyId: String
    let onBoardStatus: String
    let userId: String
    let isOffline: Bool
    
    let restaurantName: String
    let contactPerson: String
    let contactNumber: String
    let natureOfVisit: String
    let status: String
    let restaurantPic: String
    let visitingCard: String
    let latitude: Double
    let longitude: Double
    
    init(accountManagerId: String, area: String, companyId: String, onBoardStatus: String, userId: String, restaurantName: String, contactPerson: String, contactNumber: String, natureOfVisit: String, status: String, restaurantPic: String, visitingCard: String, latitude: Double, longitude: Double) {
        
        self.accountManagerId = accountManagerId
        self.area = area
        self.companyId = companyId
        self.onBoardStatus = onBoardStatus
        self.userId = userId
        
        self.restaurantName = restaurantName
        self.contactPerson = contactPerson
        self.contactNumber = contactNumber
        self.natureOfVisit = natureOfVisit
        self.status = status
        self.restaurantPic = restaurantPic
        self.visitingCard = visitingCard
        self.latitude = latitude
        self.longitude = longitude
        self.isOffline = false
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            
            "accountManagerId" ~~> self.accountManagerId,
            "area" ~~> self.area,
            "companyId" ~~> self.companyId,
            "onBoardStatus" ~~> self.onBoardStatus,
            "userId" ~~> self.userId,
            "restaurantName" ~~> self.restaurantName,
            "contactPerson" ~~> self.contactPerson,
            "contactNumber" ~~> self.contactNumber,
            "natureOfVisit" ~~> self.natureOfVisit,
            "status" ~~> self.status,
            "restaurantPic" ~~> self.restaurantPic,
            "visitingCard" ~~> self.visitingCard,
            "latitude" ~~> self.latitude,
            "longitude" ~~> self.longitude,
            "isOffline" ~~> self.isOffline
            ])
    }
}
