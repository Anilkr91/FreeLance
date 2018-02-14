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
            
            var categoryIds:[Int] = []
            var permissionList: [String] = []
        
            for permission in login.permissionList.enumerated() {
                permissionList.append(permission.element)
            }
            
            for category in login.categoryList.enumerated() {
                categoryIds.append(category.element.id)
            }
            
            Defaults[.permissionList] = permissionList
            Defaults[.token] = login.token
            Defaults[.categoryListIds] = categoryIds
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
    
    class func setCurrentUserPermission(_ permissionList: [String]?) {
        
        if let permissionList = permissionList {
            Defaults[.userPermissionMenu] = permissionList
            
        } else {
            Defaults.remove(.userPermissionMenu)
        }
    }
    
    class func getCurrentUserPermission() -> [String]? {
        if let permissionList = Defaults[.userPermissionMenu] {
            return permissionList
        }
        return nil
    }
    
    
    class func getCurrentUserPermissionList() -> [String]? {
        if let permissionList = Defaults[.permissionList] {
            return permissionList
        }
        return nil
    }
    
    class func setCurrentUserCategoryList(_ categoryList: [Int]?) {
        
        if let categoryList = categoryList {
            Defaults[.categoryListIds] = categoryList
            
        } else {
            Defaults.remove(.categoryListIds)
        }
    }
    
    class func getCurrentUserCategoryList() -> [Int]? {
        if let categoryList = Defaults[.categoryListIds] {
            return categoryList
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
