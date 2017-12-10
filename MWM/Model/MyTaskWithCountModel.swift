//
//  MyTaskWithCountModel.swift
//  MWM
//
//  Created by admin on 09/12/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import Gloss

struct MyTaskWithCountModel {
    
    let taskName: String
    let taskCount: Int
 
    init(taskName: String, taskCount: Int) {
        self.taskName = taskName
        self.taskCount = taskCount
    }
}
