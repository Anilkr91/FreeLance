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
            Defaults[.featureList] = login.featureList
            Defaults[.user] = login.user.toJSON()
            Defaults[.isLaunched] = true
        } else {
            Defaults.remove(.token)
            Defaults.remove(.featureList)
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
//            return UserModelResponse(json: json)
           return token
        }
        return nil
    }
}
