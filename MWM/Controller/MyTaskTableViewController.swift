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
    
    var taskArray: [MyTaskWithCountModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

       getTaskCount()
        setupBarButton()
    }
    
    func setupBarButton() {
        
        let rightBarButton = UIBarButtonItem(title: "+", style: UIBarButtonItemStyle.plain, target: self, action: #selector(MyTaskTableViewController.dismissModally))
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    func dismissModally() {
        
        self.performSegue(withIdentifier: "showCreateTaskSegue", sender: self)
//        self.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        cell.info = taskArray[indexPath.section]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showTaskByDurationSegue", sender: self)
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
}
