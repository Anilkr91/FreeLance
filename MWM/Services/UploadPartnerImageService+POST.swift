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



// Saving for future reference

//    static func executeRequest (data: Data, _ params:[String: Any], completionHandler: @escaping (SuccessModel) -> Void) {
//
//      Loader.sharedInstance.showLoader()
//        let header: HTTPHeaders = ["X_API_KEY" : Constants.API_KEY]
//        let URL = Constants.BASE_URL
//        //        //
//        let manager = Alamofire.SessionManager.default
//        manager.session.configuration.timeoutIntervalForRequest = 60
//
////        let data = UIImagePNGRepresentation(image)!
//
//        let request =  manager.upload(multipartFormData:{ multipartFormData in
//
//            multipartFormData.append("test".data(using: .utf8)!, withName: "userImage", mimeType: "image/png")
//            multipartFormData.append("Anil".data(using: .utf8)!, withName: "fname")
//            multipartFormData.append("Kumar".data(using: .utf8)!, withName: "lname")
//            multipartFormData.append("5".data(using: .utf8)!, withName: "loc_id")
//            multipartFormData.append("51".data(using: .utf8)!, withName: "height")
//             multipartFormData.append("56".data(using: .utf8)!, withName: "weight")
//             multipartFormData.append("about me lorem ipsum".data(using: .utf8)!, withName: "about_me")
//             multipartFormData.append("12-04-1991".data(using: .utf8)!, withName: "birthday")
//            },
//
//                                      usingThreshold:UInt64.init(),
//                                      to:URL + "profile/update_profile",
//                                      method:.post,
//                                      headers: header,
//                                      encodingCompletion: { encodingResult in
//                                        switch encodingResult {
//                                        case .success(let upload, _, _):
//
//                                            debugPrint(upload)
//                                            upload.responseJSON { response in
//                                                debugPrint(response)
//                                            }
//                                        case .failure(let encodingError):
//                                            print(encodingError)
//                                        }
//        })
//
//        debugPrint(request)
//    }
