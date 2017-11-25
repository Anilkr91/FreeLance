//
//  LoginUtils.swift
//  Demo
//
//  Created by admin on 28/09/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import SwiftyUserDefaults

class LoginUtils {
    
    class func setCurrentUser(_ user: UserModel?) {
        if let user = user {
            Defaults[.user] = user.toJSON()
            
        } else {
            Defaults.remove(.user)
        }
    }
    
    class func setCurrentUserLogin(_ login: UserModelResponse?) {
        if let login = login {
            Defaults[.token] = login.token
            Defaults[.permissionList] = login.permissionList
            Defaults[.user] = login.user.toJSON()
            Defaults[.isLaunched] = true
            
        } else {
            Defaults.remove(.token)
            Defaults.remove(.permissionList)
        }
    }
    
    class func getCurrentUser() -> UserModel? {
        if let json = Defaults[.user] {
            return UserModel(json: json)
        }
        return nil
    }
    
    class func getCurrentUserLogin() -> String? {
        if let token = Defaults[.token] {
            return token
        }
        return nil
    }
    
    class func setCurrentUserAttendence(_ attendence: AttendenceModel?) {
        if let attendence = attendence {
            Defaults[.attendence] = attendence.toJSON()
            
        } else {
            Defaults.remove(.attendence)
        }
    }
    
    class func getCurrentUserAttendence() -> AttendenceModel? {
        if let json = Defaults[.attendence] {
            return AttendenceModel(json: json)
        }
        return nil
    }
    
    class func setCurrentUserSession(_ id: Int?) {
        if let id = id {
            Defaults[.sessionId] = id
            
        } else {
            Defaults.remove(.sessionId)
        }
    }
    
    class func getCurrentUserSession() -> Int? {
        if let id = Defaults[.sessionId] {
            return id
        }
        return nil
    }
}
