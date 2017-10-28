//
//  LoginService+POST.swift
//  Demo
//
//  Created by admin on 28/09/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import Alamofire
import Gloss

class LoginPostService {
    static func executeRequest (_ params:[String: AnyObject], completionHandler: @escaping (UserModelResponse) -> Void) {
        
        ProgressBarView.showHUD()
        let URL = Constants.BASE_URL
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 60
        
        manager.request( URL + "user/login", method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            
            switch response.result {
            case .success(let value) :
                
                guard let data = GlossResponse<UserModelResponse>(json: value as! JSON) else {  return }
                
                if data.status == true {
                     ProgressBarView.hideHUD()
                    completionHandler(data.objectData!)
                    
                } else {
                    ProgressBarView.hideHUD()
                    let error =  ErrorModel(json: value as! JSON)
                    Alert.showAlertWithMessage("Error", message: error!.errorMessage)
                }
            case .failure(let error):
                ProgressBarView.hideHUD()
                Alert.showAlertWithMessage("Error", message: error.localizedDescription)
            }
        }
    }
}
