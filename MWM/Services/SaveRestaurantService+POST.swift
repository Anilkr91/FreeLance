//
//  SaveRestaurantService+POST.swift
//  Demo
//
//  Created by admin on 30/09/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import Alamofire
import Gloss

class SaveRestaurantPostService {
    static func executeRequest (_ params:[String: Any], completionHandler: @escaping (Bool) -> Void) {
        
        ProgressBarView.showHUD()
        let BaseURL = Constants.BASE_URL
        let token = LoginUtils.getCurrentUserLogin()

        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 60
        
        let headers: HTTPHeaders = ["AUTH-TOKEN": token!]
        
   let r =  manager.request( BaseURL + "restaurant", method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            
            switch response.result {
            case .success(let value) :
                
                let data = SaveRestaurantResponse(json: value as! JSON)
                if data!.status == true {
                    ProgressBarView.hideHUD()
                    completionHandler(data!.status)
                    
                } else {
                    ProgressBarView.hideHUD()
                    Alert.showAlertWithMessage("Error", message: "Data not saved might be problem at server")
                }
            case .failure(let error):
                ProgressBarView.hideHUD()
                Alert.showAlertWithMessage("Error", message: error.localizedDescription)
            }
        }
        debugPrint(r)
    }
}
