//
//  ValidateTokenService+GET.swift
//  Demo
//
//  Created by admin on 28/09/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import Alamofire
import Gloss

class ValidateTokenPostService {
    static func executeRequest (completionHandler: @escaping (IsSuccessModel) -> Void) {
        
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 60
        
        let user = LoginUtils.getCurrentUser()
        
        let BaseURL = Constants.BASE_URL
        let pathParam = user!.id
        
        let token = LoginUtils.getCurrentUserLogin()
        
        manager.request( BaseURL + "user/validate-token/\(pathParam)?token=\(token!)", method: .put, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            
            switch response.result {
            case .success(let value) :
                if let data = IsSuccessModel(json: value as! JSON) {
                    ProgressBarView.hideHUD()
                    completionHandler(data)
                } else {
                    ProgressBarView.hideHUD()
                    
                    let error = ErrorModel(json: value as! JSON)
                    let application = UIApplication.shared.delegate as! AppDelegate
                    
                    application.setHomeGuestAsRVC()
                    LoginUtils.setCurrentUserLogin(nil)
                    Alert.showAlertWithMessage("Error", message: error!.errorMessage)
                    
                }
            case .failure(let error):
                ProgressBarView.hideHUD()
                Alert.showAlertWithMessage("Error", message: error.localizedDescription)
            }
        }
        
    }
}
