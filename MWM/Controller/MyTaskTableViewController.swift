//
//  MyTaskTableViewController.swift
//  MWM
//
//  Created by admin on 09/12/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import UIKit

class MyTaskTableViewController: UITableViewController {
    
    //    let taskArray = ["Today's Task", "Pending Task", "Upcoming Task", "Completed Task"]
    //    let adminTaskArray = ["Today's Task", "Pending Task", "Upcoming Task", "Completed Task", "View All Task"]
    
    var taskCount: MyTaskModel?
    var taskType: String?
    var taskArray: [MyTaskWithCountModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getTaskCount()
        setupBarButton()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        getTaskCount()
//        
//    }
    
    func setupBarButton() {
        
        let rightBarButton = UIBarButtonItem(title: "+", style: UIBarButtonItemStyle.plain, target: self, action: #selector(MyTaskTableViewController.dismissModally))
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    func dismissModally() {
        
        self.performSegue(withIdentifier: "showCreateTaskSegue", sender: self)
    }
    
    func getTaskCount() {
        
        MyTaskCountGetService.executeRequest { (response) in
            self.taskCount = response
            self.createTaskArray(taskCount: response)
            self.tableView.reloadData()
        }
    }
    
    func createTaskArray(taskCount: MyTaskModel) {
        taskArray.append(MyTaskWithCountModel(taskName: "Today's Task", taskCount: taskCount.todayTaskCount))
        taskArray.append(MyTaskWithCountModel(taskName: "Pending Task", taskCount: taskCount.pendingTaskCount))
        taskArray.append(MyTaskWithCountModel(taskName: "Upcoming Task", taskCount: taskCount.upcomingTaskCount))
        taskArray.append(MyTaskWithCountModel(taskName: "Completed Task", taskCount: taskCount.completedTaskCount))
        taskArray.append(MyTaskWithCountModel(taskName: "View All Task", taskCount: taskCount.totalTaskCount))
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MyTaskTableViewCell
        
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
        cell.info = taskArray[indexPath.section]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if taskArray[indexPath.section].taskName == "Today's Task" {
            taskType = "Today"
        performSegue(withIdentifier: "showTaskByDurationSegue", sender: self)
        
        
        } else if taskArray[indexPath.section].taskName == "Pending Task" {
             taskType = "Pending"
          performSegue(withIdentifier: "showTaskByDurationSegue", sender: self)
        
       
        } else if taskArray[indexPath.section].taskName == "Upcoming Task" {
             taskType = "Upcoming"
          performSegue(withIdentifier: "showTaskByDurationSegue", sender: self)
        
        
        } else if taskArray[indexPath.section].taskName == "Completed Task" {
             taskType = "Completed"
          performSegue(withIdentifier: "showTaskByDurationSegue", sender: self)
        
        
        } else if taskArray[indexPath.section].taskName == "View All Task" {
             taskType = "All"
          performSegue(withIdentifier: "showTaskByDurationSegue", sender: self)
        
        } else {
            return
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showTaskByDurationSegue" {
            
            let dvc = segue.destination as! MyTaskByDurationTableViewController
            dvc.taskType = taskType
        }
    }
}
