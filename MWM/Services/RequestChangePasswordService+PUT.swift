//
//  RequestChangePasswordService+PUT.swift
//  Demo
//
//  Created by admin on 14/10/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import Alamofire
import Gloss

class RequestChangePasswordPostService {
    static func executeRequest (_ params:[String: Any], completionHandler: @escaping (BaseSucessModel) -> Void) {
        
        ProgressBarView.showHUD()
        let BaseURL = Constants.BASE_URL
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 60
        
        let headers: HTTPHeaders = ["Device-Type": "iOS"]
    
      let r =   manager.request( BaseURL + "user/request-password-reset", method: .put, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            
            switch response.result {
            case .success(let value) :
                if let data = BaseSucessModel(json: value as! JSON) {
                    ProgressBarView.hideHUD()
                    completionHandler(data)
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
        
        debugPrint(r)
    }
}
