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
    
    var duration: String = ""
    var currentPage = 0
    var totalElements = 0
    var isLoadMore: Bool = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let taskType = taskType {
            
            duration = taskType
           getTaskByDurationCount(pageNumber: currentPage)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func loadMoreFooterView(count: Int) {
        
        if totalElements == count {
            let frame = CGRect(x: 0, y: 0, width: self.tableView.frame.size.width, height: 40)
            let footerView = UIView(frame: frame)
            footerView.backgroundColor = UIColor.purple
            
            let label:UILabel = UILabel()
            label.frame = CGRect(x: 0, y: 0, width: self.tableView.frame.size.width, height: 40)
            label.text = "No More Partners to Show"
            label.textColor = UIColor.white
            label.textAlignment =  .center
            footerView.addSubview(label)
            self.tableView.tableFooterView = footerView
            
        } else {
            
            let frame = CGRect(x: 0, y: 0, width: self.tableView.frame.size.width, height: 40)
            let footerView = UIView(frame: frame)
            let button = UIButton(type: .roundedRect)
            button.frame = CGRect(x: 0, y: 0, width: self.tableView.frame.size.width, height: 40)
            button.setTitle("Load More", for: .normal)
            button.backgroundColor =  UIColor.purple
            button.tintColor =  UIColor.white
            button.addTarget(self, action: #selector(self.loadMorePartners), for: .touchUpInside)
            footerView.addSubview(button)
            self.tableView.tableFooterView = footerView
            
        }
    }
    
    
    func getTaskByDurationCount(pageNumber: Int) {
        
        let param = ["pageNumber": pageNumber, "pageSize" : 20] as [String : Any]
        MyTaskByDurationGetService.executeRequest(param, duration: duration) { (response) in
                       
            self.totalElements =  response.totalElements
            
            if pageNumber == 0 {
                self.taskArray = response.data
            } else {
                self.taskArray += response.data
            }
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
        cell.index = indexPath.section
        
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        cell.info = taskArray[indexPath.section]
        
        if cell.index == taskArray.count - 1 {
            if totalElements >= taskArray.count {
                
                loadMoreFooterView(count: taskArray.count)
            }
        }
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
    
    
    func loadMorePartners(_ sender: LoadMoreTableViewCell) {
        print("load more tapped")
        
        
        self.currentPage = currentPage+1
        
        getTaskByDurationCount(pageNumber: currentPage)
    }
}
