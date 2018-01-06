//
//  TaskDetailAlert.swift
//  MWM
//
//  Created by admin on 16/12/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import UIKit

class TaskDetailAlert: BaseTableViewController {
    
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
        tableView.separatorStyle = .none
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let taskDetailObject = taskDetailObject {
            print(taskDetailObject)
            setupDetailTask(object: taskDetailObject)
        }
    }
    
    func setupDetailTask(object: MyTaskWithDurationModel) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MM YYYY hh:mm:ss a"
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        let date =  Date(timeIntervalSince1970: object.dueDate/1000)
        let dateString = dateFormatter.string(from: date)
        
        taskNameLabel.text = "Task Name: \(object.name)"
        descriptionLabel.text = "Description: \(object.description)"
        assignedBy.text = "Assigned by: \(object.assignedBy)"
        dueDateLabel.text = "Due Date: \(dateString)"
        priorityLabel.text = "Priority: \(object.priority)"
        statusLabel.text = "Status: \(object.status)"
        localityLabel.text = "Locality: \(object.area)"
        contactLabel.text = "Contact: \(object.partnerPhoneNumber)"
        addressLabel.text = "Address: \(object.partnerAddress)"
        
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.selectionStyle = .none
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
        
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}
