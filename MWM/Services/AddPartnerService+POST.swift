//
//  AddPartnerService+POST.swift
//  MWM
//
//  Created by admin on 11/11/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import Alamofire
import Gloss

class AddPartnerPostService {
    static func executeRequest (_ params:[String: Any], completionHandler: @escaping (BaseSucessModel) -> Void) {
        
        ProgressBarView.showHUD()
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 60
        
        let BaseURL = Constants.BASE_URL
        
        manager.request( BaseURL + "partner", method: .get, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            
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
    }
}
