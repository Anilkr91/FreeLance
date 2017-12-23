//
//  TaskDetailAlert.swift
//  MWM
//
//  Created by admin on 16/12/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import UIKit

class TaskDetailAlert: UIViewController {
    
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var assignedBy: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var priorityLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var localityLabel: UILabel!
    @IBOutlet weak var contactLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    var taskDetailObject: MyTaskWithDurationModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let taskDetailObject = taskDetailObject {
            setupDetailTask(object: taskDetailObject)
        }
        
    }
    
    func setupDetailTask(object: MyTaskWithDurationModel) {
        
        
        taskNameLabel.text = object.description
        descriptionLabel.text = object.description
        assignedBy.text = object.assignedBy
        //        dueDateLabel.text = object.
        priorityLabel.text = object.priority
        statusLabel.text = object.status
        //        localityLabel.text = object
        //        contactLabel.text = object
        addressLabel.text = object.partnerAddress
        
    }
}
