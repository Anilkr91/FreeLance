//
//  UploadPartnerImageService+POST.swift
//  MWM
//
//  Created by admin on 25/11/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import Alamofire
import Gloss

class UploadPartnerImagePostService {
    static func executeRequest (_ data: Data, completionHandler: @escaping (ImageModel) -> Void) {
        
        let BaseURL = Constants.BASE_URL
        let token = LoginUtils.getCurrentUserLogin()
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 60
        
        let headers: HTTPHeaders = ["AUTH-TOKEN": token!]
        
        manager.upload(multipartFormData:{ multipartFormData in
            
            multipartFormData.append(data, withName: "file", fileName: "image", mimeType: "image/png")
            
        },
                       usingThreshold:UInt64.init(),
                       to: BaseURL + "upload/partner",
                       method:.post,
                       headers: headers,
                       encodingCompletion: { encodingResult in
                        
                        switch encodingResult {
                            
                        case .success(let upload, _, _):
                            upload.responseJSON { response in
                                if let info = response.result.value as? [String: Any]  {
                                    let data = ImageModel(json: info )
                                    completionHandler(data!)
                                }
                            }
                        case .failure(let encodingError):
                            ProgressBarView.hideHUD()
                            Alert.showAlertWithMessage("Request Not Completed", message: encodingError.localizedDescription)
                            
                        }
        })
        
    }
}
