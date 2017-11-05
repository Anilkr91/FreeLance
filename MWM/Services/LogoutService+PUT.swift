//
//  LogoutService+POST.swift
//  Demo
//
//  Created by admin on 28/09/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import Alamofire
import Gloss

class LogoutGetService {
    static func executeRequest (completionHandler: @escaping (BaseSucessModel) -> Void) {
        
        ProgressBarView.showHUD()
        let BaseURL = Constants.BASE_URL
        let token = LoginUtils.getCurrentUserLogin()
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 60
        
        let headers: HTTPHeaders = ["AUTH-TOKEN": token!]
        
        manager.request( BaseURL + "user/logout", method: .put, parameters: nil, encoding: URLEncoding.default, headers: headers).responseJSON { response in
            
            switch response.result {
            case .success(let value) :
                if let result = BaseSucessModel(json: value as! JSON) {
                    ProgressBarView.hideHUD()
                    completionHandler(result)
                } else {
                    ProgressBarView.hideHUD()
                    let error = ErrorModel(json: value as! JSON)
                    Alert.showAlertWithMessage("Error", message: error!.errorMessage)
                }
            case .failure(let error):
                ProgressBarView.hideHUD()
                Alert.showAlertWithMessage("Error", message: error.localizedDescription)
            }
        }
        
    }
}
