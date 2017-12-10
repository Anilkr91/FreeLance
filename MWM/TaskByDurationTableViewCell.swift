//
//  TaskByDurationTableViewCell.swift
//  MWM
//
//  Created by admin on 09/12/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import Foundation

import UIKit

class TaskByDurationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var partnerLabel: UILabel!
    @IBOutlet weak var taskStatusLabel: UILabel!
    @IBOutlet weak var localityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    var info: MyTaskWithDurationModel? {
        didSet {
            if let member = info {
                didSetCategory(member)
            }
        }
    }
}

extension TaskByDurationTableViewCell {
    
    func didSetCategory(_ info: MyTaskWithDurationModel) {
        
        titleLabel.text = info.name
        partnerLabel.text = info.partnerName
         taskStatusLabel.text = info.status
        localityLabel.text = info.area
        
    }
}
