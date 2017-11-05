//
//  DefaultsKeys.swift
//  Demo
//
//  Created by admin on 28/09/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import SwiftyUserDefaults

extension DefaultsKeys {
    
    static let token = DefaultsKey<String?>("token")
    static let featureList = DefaultsKey<String?>("featureList")
    static let user = DefaultsKey<[String: Any]?>("user")
    static let attendence = DefaultsKey<[String: Any]?>("attendence")
    static let isLaunched = DefaultsKey<Bool>("launch")
    static let sessionId = DefaultsKey<Int?>("sessionId")
   
}
