//
//  MyTaskCountServices+GET.swift
//  MWM
//
//  Created by admin on 09/12/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import Alamofire
import Gloss

class MyTaskCountGetService {
    static func executeRequest ( completionHandler: @escaping (MyTaskModel) -> Void) {
        
        ProgressBarView.showHUD()
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 60
        
        let BaseURL = Constants.BASE_URL
        
        let token = LoginUtils.getCurrentUserLogin()
        let headers: HTTPHeaders = ["AUTH-TOKEN": token!]
        
        
        let r =  manager.request( BaseURL + "task/duration-count", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            
            switch response.result {
            case .success(let value) :
                
                print(value)
                
                if let info = MyTaskModelResponse(json: value as! JSON) {
                    ProgressBarView.hideHUD()
                    completionHandler(info.data)
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
