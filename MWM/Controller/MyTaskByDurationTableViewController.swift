//
//  MyTaskByDurationTableViewController.swift
//  MWM
//
//  Created by admin on 09/12/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import UIKit
import MZFormSheetPresentationController

class MyTaskByDurationTableViewController: UITableViewController {
    
    var taskArray: [MyTaskWithDurationModel] = []
    var taskDetailObject: MyTaskWithDurationModel?
    var taskType: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let taskType = taskType {
           getTaskByDurationCount(duration: taskType)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getTaskByDurationCount(duration: String) {
        
        let param = ["pageNumber": 0, "pageSize" : 20] as [String : Any]
        MyTaskByDurationGetService.executeRequest(param, duration: duration) { (response) in
            self.taskArray = response
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        return taskArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TaskByDurationTableViewCell
        
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        cell.info = taskArray[indexPath.section]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        taskDetailObject = taskArray[indexPath.section]
        performSegue(withIdentifier: "showDetailTaskSegue", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showDetailTaskSegue" {
            let presentationSegue = segue as! MZFormSheetPresentationViewControllerSegue
            let navigationController = presentationSegue.formSheetPresentationController.contentViewController as! TaskDetailAlert
            let formSheetController = MZFormSheetPresentationViewController(contentViewController: navigationController)
            formSheetController.presentationController?.contentViewSize = CGSize(width: 350, height: 480)
            formSheetController.presentationController?.shouldCenterVertically = true
            formSheetController.contentViewControllerTransitionStyle = .bounce
            formSheetController.presentationController?.shouldDismissOnBackgroundViewTap = true
            self.present(formSheetController, animated: true, completion: nil)
            navigationController.title = "Task Detail"
            navigationController.taskDetailObject = taskDetailObject
        }
    }
    
}
