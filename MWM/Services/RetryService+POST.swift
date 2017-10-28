//
//  RetryService+POST.swift
//  Demo
//
//  Created by admin on 02/10/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import Alamofire
import Gloss

class RetryPostService {
    static func executeRequest (_ params:[String: AnyObject], completionHandler: @escaping (SucessModel) -> Void) {
        
        ProgressBarView.showHUD()
        let BaseURL = Constants.BASE_URL
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 60
        
        manager.request( BaseURL + "user/retry-otp", method: .put, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            
            switch response.result {
            case .success(let value) :
                let data = SucessModel(json: value as! JSON)
                
                if data != nil {
                    ProgressBarView.hideHUD()
                    completionHandler(data!)
                    
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
