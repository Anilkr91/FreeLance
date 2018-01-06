//
//  MyTaskWithDurationModel.swift
//  MWM
//
//  Created by admin on 09/12/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import Gloss

struct MyTaskWithDurationModel: Gloss.Decodable {
    
    let active: Bool
    let area: String
    let assignedBy: String
    let assignedByName: String
    let assignedTo: String
    let assignedToName: String
    let cancelationReason: String?
    let companyId: String
    let description: String
    let deviceType: String
    let dueDate: Double
    let id: Int
    let latitude: String?
    let longitude: String?
    let message: String?
    let name: String
    let partnerAddress: String
    let partnerId: Int
    let partnerName: String
    let partnerPhoneNumber: String
    let priority: String
    let rescheduledDate: Double?
    let signature: String?
    let status: String
    let taskImage: String?
    let timeOfDay: String
    
    
    init?(json: JSON) {
        
        guard let active: Bool = "active" <~~ json,
            let area: String = "area" <~~ json,
            let assignedBy: String = "assignedBy" <~~ json,
            let assignedByName: String = "assignedByName" <~~ json,
            let assignedTo: String = "assignedTo" <~~ json,
            let assignedToName: String = "assignedToName" <~~ json,
            let companyId: String = "companyId" <~~ json,
            let description: String = "description" <~~ json,
            let deviceType: String = "deviceType" <~~ json,
            let dueDate: Double = "dueDate" <~~ json,
            let id: Int = "id" <~~ json,
            let name: String = "name" <~~ json,
            let partnerAddress: String = "partnerAddress" <~~ json,
            let partnerId: Int = "partnerId" <~~ json,
            let partnerName: String = "partnerName" <~~ json,
            let partnerPhoneNumber: String = "partnerPhoneNumber" <~~ json,
            let priority: String = "priority" <~~ json,
            let status: String = "status" <~~ json,
            let timeOfDay: String = "timeOfDay" <~~ json else { return nil }
        
        self.active = active
        self.area = area
        self.assignedBy = assignedBy
        self.assignedByName = assignedByName
        self.assignedTo = assignedTo
        self.assignedToName = assignedToName
        self.cancelationReason = "cancelationReason" <~~ json
        self.companyId = companyId
        self.description = description
        self.deviceType = deviceType
        self.dueDate =  dueDate
        self.id = id
        self.latitude = "latitude" <~~ json
        self.longitude = "longitude" <~~ json
        self.message = "message" <~~ json
        self.name = name
        self.partnerAddress = partnerAddress
        self.partnerId = partnerId
        self.partnerName = partnerName
        self.partnerPhoneNumber = partnerPhoneNumber
        self.priority = priority
        self.rescheduledDate = "rescheduledDate" <~~ json
        self.signature = "signature" <~~ json
        self.status = status
        self.taskImage = "taskImage" <~~ json
        self.timeOfDay = timeOfDay
        
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            
            "active" ~~> self.active,
            "area" ~~> self.area,
            "assignedBy" ~~> self.assignedBy,
            "assignedByName" ~~> self.assignedByName,
            "assignedTo" ~~> self.assignedTo,
            "assignedToName" ~~> self.assignedToName,
            "cancelationReason" ~~> self.cancelationReason,
            "companyId" ~~> self.companyId,
            "description" ~~> self.description,
            "deviceType" ~~> self.deviceType,
            "dueDate" ~~> self.dueDate,
            "id" ~~> self.id,
            "latitude" ~~> self.latitude,
            "longitude" ~~> self.longitude,
            "message" ~~> self.message,
            "name" ~~> self.name,
            "partnerAddress" ~~> self.partnerAddress,
            "partnerId" ~~> self.partnerId,
            "partnerName" ~~> self.partnerName,
            "partnerPhoneNumber" ~~> self.partnerPhoneNumber,
            "priority" ~~> self.priority,
            "rescheduledDate" ~~> self.rescheduledDate,
            "signature" ~~> self.signature,
            "status" ~~> self.status,
            "taskImage" ~~> self.taskImage,
            "timeOfDay"  ~~> self.timeOfDay,
            
            ])
    }
}
