//
//  CustomRoleService+GET.swift
//  MWM
//
//  Created by admin on 06/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import Alamofire
import Gloss

class CustomRoleGetService {
    static func executeRequest ( _ params:[String: Any], completionHandler: @escaping (CustomRoleModelArray) -> Void) {
        
        ProgressBarView.showHUD()
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 60
        
        let BaseURL = Constants.BASE_URL
        
        let token = LoginUtils.getCurrentUserLogin()
        let headers: HTTPHeaders = ["AUTH-TOKEN": token!]
        
        let r =  manager.request( BaseURL + "custom-role", method: .get, parameters: params, encoding: URLEncoding.default, headers: headers).responseJSON { response in
            
            switch response.result {
            case .success(let value) :
                
                print(value)
                
                if let info = CustomRoleModelArray(json: value as! JSON) {
                    ProgressBarView.hideHUD()
                    completionHandler(info)
                } else {
                    
                    ProgressBarView.hideHUD()
                    //                    let error = ErrorModel(json: value as! JSON)
                    //
                    //                    Alert.showAlertWithMessage("Error", message: error!.errorMessage)
                }
                
            case .failure(let error):
                ProgressBarView.hideHUD()
                Alert.showAlertWithMessage("Error", message: error.localizedDescription)
            }
        }
        
        debugPrint(r)
    }
}
