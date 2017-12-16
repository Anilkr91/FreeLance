//
//  CreateTaskServices+POST.swift
//  MWM
//
//  Created by admin on 16/12/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import Alamofire
import Gloss

class CreateTaskPostService {
    static func executeRequest (_ params:[String: Any], completionHandler: @escaping (SucessModel) -> Void) {
        
        ProgressBarView.showHUD()
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 60
        
        let BaseURL = Constants.BASE_URL
    
        let token = LoginUtils.getCurrentUserLogin()
        
        let headers: HTTPHeaders = ["AUTH-TOKEN": token!,
                                    "Device-Type": "iOS"]
        
        
        let r =  manager.request( BaseURL + "task", method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            
            switch response.result {
            case .success(let value) :
                
                print(value)
                
                
                if let result = SucessModel(json: value as! JSON) {
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
        
        debugPrint(r)
    }
}
