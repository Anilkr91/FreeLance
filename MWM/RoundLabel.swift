//
//  RoundLabel.swift
//  MWM
//
//  Created by admin on 23/12/17.
//  Copyright © 2017 Techximum. All rights reserved.
//


import UIKit

class RoundLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        clipsToBounds = true
        layer.cornerRadius = frame.width/2;
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.red.cgColor
        backgroundColor = UIColor.red
    }
}
