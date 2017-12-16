//
//  CreateTaskRequestModel.swift
//  MWM
//
//  Created by admin on 16/12/17.
//  Copyright © 2017 Techximum. All rights reserved.
//


import Gloss

struct CreateTaskRequestModel {

    let assignedBy: String
    let assignedTo: String
    let name: String
    let description: String
    let partnerIdList: [Int]
    let dueDate: Int
    let priority: String
    
    init (name: String, description: String, assignedBy: String, assignedTo: String, partnerIdList: [Int], dueDate: Int, priority: String) {
        
        self.assignedBy = assignedBy
        self.assignedTo = assignedTo
        self.name = name
        self.description = description
        self.partnerIdList = partnerIdList
        self.dueDate = dueDate
        self.priority = priority
        
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            
            "assignedBy" ~~> self.assignedBy,
            "assignedTo" ~~> self.assignedTo,
            "name" ~~> self.name,
            "description" ~~> self.description,
            "partnerIdList" ~~> self.partnerIdList,
            "dueDate" ~~> self.dueDate,
            "priority" ~~> self.priority
        
            
            ])
    }
}
