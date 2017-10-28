//
//  AlertView+Helper.swift
//  StayAPT
//
//  Created by admin on 05/09/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import UIKit

class Alert {
    
    static func showAlertWithMessage(_ title: String ,message:String) {
        let alertView = UIApplication.shared.windows[0].rootViewController
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(action: UIAlertAction!) in
        }))
        alertView!.present(alert, animated: true, completion: nil)
    }
}
