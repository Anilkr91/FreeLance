//
//  MyTaskByDurationTableViewController.swift
//  MWM
//
//  Created by admin on 09/12/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import UIKit

class MyTaskByDurationTableViewController: UITableViewController {
    
    var taskArray: [MyTaskWithDurationModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getTaskByDurationCount()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getTaskByDurationCount() {
        
        let param = ["pageNumber": 0, "pageSize" : 20] as [String : Any]
        MyTaskByDurationGetService.executeRequest(param, duration: "All") { (response) in
            print(response)
            
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
}
