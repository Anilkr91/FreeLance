//
//  ValidateCredentialsService+GET.swift
//  MWM
//
//  Created by admin on 13/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import Alamofire
import Gloss

class ValidateCredentialsGetService {
    static func executeRequest ( _ params: String, completionHandler: @escaping ([CompanyModel]) -> Void) {
        
        ProgressBarView.showHUD()
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 60
        
        let BaseURL = Constants.BASE_URL
        
        let r =  manager.request( BaseURL + "user/validate-credentials/?credential=\(params)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            
            switch response.result {
            case .success(let value) :
                
                if let info = CompanyModelArray(json: value as! JSON) {
                    ProgressBarView.hideHUD()
                    completionHandler(info.data)
                } else {
                    ProgressBarView.hideHUD()
                }
                
            case .failure(let error):
                ProgressBarView.hideHUD()
                Alert.showAlertWithMessage("Error", message: error.localizedDescription)
            }
        }
        
        debugPrint(r)
    }
}
