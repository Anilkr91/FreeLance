//
//  MyTaskModel.swift
//  MWM
//
//  Created by admin on 09/12/17.
//  Copyright © 2017 Techximum. All rights reserved.
//


import Gloss

struct MyTaskModel: Gloss.Decodable {
    
    let completedTaskCount: Int
    let pendingTaskCount: Int
    let todayTaskCount: Int
    let totalTaskCount: Int
    let upcomingTaskCount: Int
    
    init?(json: JSON) {
        
        guard let completedTaskCount: Int = "completedTaskCount" <~~ json,
            let pendingTaskCount: Int = "pendingTaskCount" <~~ json,
            let todayTaskCount: Int = "todayTaskCount" <~~ json,
            let totalTaskCount: Int = "totalTaskCount" <~~ json,
            let upcomingTaskCount: Int = "upcomingTaskCount" <~~ json else { return nil }
        
        self.completedTaskCount = completedTaskCount
        self.pendingTaskCount = pendingTaskCount
        self.todayTaskCount = todayTaskCount
        self.totalTaskCount = totalTaskCount
        self.upcomingTaskCount = upcomingTaskCount
        
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "completedTaskCount" ~~> self.completedTaskCount,
            "pendingTaskCount" ~~> self.pendingTaskCount,
            "todayTaskCount" ~~> self.todayTaskCount,
            "totalTaskCount" ~~> self.totalTaskCount,
            "upcomingTaskCount" ~~> self.upcomingTaskCount,
            ])
    }
}
