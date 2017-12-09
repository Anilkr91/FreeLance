//
//  FootPrintService+POST.swift
//  MWM
//
//  Created by admin on 12/11/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import Alamofire
import Gloss

class FootPrintPostService {
    
    static func executeRequest (_ params:[String: Any], completionHandler: @escaping (IsSuccessModel) -> Void) {
        
        ProgressBarView.showHUD()
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 60
        
        let BaseURL = Constants.BASE_URL
        
        let token = LoginUtils.getCurrentUserLogin()
        let headers: HTTPHeaders = ["AUTH-TOKEN": token!]
        
       let r = manager.request( BaseURL + "user-footprint/ios", method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
        
            switch response.result {
            case .success(let value) :
                
                if let data = IsSuccessModel(json: value as! JSON) {
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
