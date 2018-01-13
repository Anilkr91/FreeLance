//
//  UsersListTableViewController.swift
//  MWM
//
//  Created by admin on 16/12/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import UIKit

protocol UserDelegte {
    func sendUserDelegate(user: UserListResponseModel)
}


class UsersListTableViewController: BaseTableViewController {
    
    
     var delegate: UserDelegte?
    
    let searchController = UISearchController(searchResultsController: nil)
    let user = LoginUtils.getCurrentUser()!
    var array: [UserListResponseModel] = []
    var filteredArray = [UserListResponseModel]()
    var userModel: UserListResponseModel?
    
    var currentPage = 0
    var totalElements = 0
    var isLoadMore: Bool = false
    var categoryIds: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filteredArray = array
        
        let param = ["pageNumber" : 0, "pageSize": 10]
        UserListGetService.executeRequest(param) { (response) in
            self.array = response.data
            self.tableView.reloadData()
        }
    }

    func setupBarButton() {
        
        let rightBarButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(UsersListTableViewController.done))
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    func done() {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return array.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! UsersListTableViewCell
        cell.info = array[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 100
        
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        userModel = array[indexPath.row]
        
        
        self.dismiss(animated: true) {
            self.delegate?.sendUserDelegate(user: self.userModel!)
        }
    }
}
