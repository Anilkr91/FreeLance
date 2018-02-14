//
//  DoubleExtension+Helper.swift
//  MWM
//
//  Created by admin on 20/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import UIKit

extension Double {
    //    / Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    
    func truncate(places : Int)-> Double
    {
        return Double(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
    }
    
}
