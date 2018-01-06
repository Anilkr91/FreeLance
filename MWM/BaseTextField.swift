//
//  BaseTextField.swift
//  MWM
//
//  Created by admin on 23/12/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import UIKit

class BaseTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setBottomLine()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        setBottomLine()
    }
    
    func setup() {
        backgroundColor = UIColor.clear
    }
    
    func setBottomLine() {
        self.borderStyle = UITextBorderStyle.none
        self.backgroundColor = UIColor.clear
    }
}
