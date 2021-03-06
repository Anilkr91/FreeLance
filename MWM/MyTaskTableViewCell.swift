//
//  MyTaskTableViewCell.swift
//  MWM
//
//  Created by admin on 09/12/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import UIKit

class MyTaskTableViewCell: UITableViewCell {
    
    @IBOutlet weak var taskCountLabel: UILabel!
    @IBOutlet weak var taskNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    var info: MyTaskWithCountModel? {
        didSet {
            if let member = info {
                didSetCategory(member)
            }
        }
    }
}

extension MyTaskTableViewCell {
    
    func didSetCategory(_ info: MyTaskWithCountModel) {
        
        taskCountLabel.text = "\(info.taskCount)"
        
        taskCountLabel.backgroundColor = UIColor(red: .random(), green: .random(), blue: .random(), alpha: 1.0)
        taskNameLabel.text = info.taskName
        
    }
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
