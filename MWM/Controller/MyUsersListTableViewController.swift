//
//  MyUsersListTableViewController.swift
//  MWM
//
//  Created by admin on 06/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import UIKit

class MyUsersListTableViewController: BaseTableViewController,UISearchResultsUpdating, UISearchBarDelegate {
    
    let searchController = UISearchController(searchResultsController: nil)
    let user = LoginUtils.getCurrentUser()!
    var array: [UserListResponseModel] = []
//    var filteredArray = [UserListResponseModel]()
    var userModel: UserListResponseModel?
    var searchString: String = ""
    var currentPage = 0
    var totalElements = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        filteredArray = array
        showUsersList(pageNumber: currentPage)
        setupSearchController()
        
    }
    
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        self.searchController.searchBar.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search by PartnerName"
        searchController.searchBar.sizeToFit()
        searchController.searchBar.becomeFirstResponder()
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
    }
    
    func showUsersList(pageNumber: Int) {
        
        let param = ["pageNumber" : pageNumber, "pageSize": 20]
        
        UserListGetService.executeRequest(param) { (response) in
            
            self.totalElements =  response.totalElements
            
            if pageNumber == 0 {
                self.array = response.data
            } else {
                self.array += response.data
            }
            self.tableView.reloadData()
        }
    }
    
    func searchUsersList(searchString: String) {
        let param = ["pageNumber": 0, "pageSize" : 20, "searchKey":searchString] as [String : Any]
        
        SearchUserListGetService.executeRequest(param) { (response) in
            
            self.array = response.data
            self.tableView.reloadData()
        }
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
    
    func loadMorePartners(_ sender: LoadMoreTableViewCell) {
        print("load more tapped")
        
        self.currentPage = currentPage+1
        showUsersList(pageNumber: currentPage)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        searchString = searchController.searchBar.text!
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        if searchString.removeAllSpaces().isEmpty {
            return
            
        } else {
            showUsersList(pageNumber: currentPage)
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
        if searchString.removeAllSpaces().isEmpty {
            return
            
        } else {
            searchUsersList(searchString: searchBar.text!)
            
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
        return array.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MyUsersListTableViewCell
        cell.info = array[indexPath.section]
        cell.selectionStyle = .none
        
        cell.resetButton.tag = indexPath.section
        cell.editButton.tag = indexPath.section
        cell.switchButton.tag = indexPath.section
        
        
        cell.resetButton.addTarget(self, action:#selector(MyUsersListTableViewController.resetButtonButton), for: .touchUpInside)
        cell.editButton.addTarget(self, action:#selector(MyUsersListTableViewController.editButtonTapped), for: .touchUpInside)
        cell.switchButton.addTarget(self, action:#selector(MyUsersListTableViewController.switchButtonTapped), for: .touchUpInside)
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
        userModel = array[indexPath.row]
        
    }
    
    func resetButtonButton(sender: UIButton) {
        
        print(sender.tag)

        let id = array[sender.tag].id
        print("reset options")
        
        
        PasswordResetPutService.executeRequest(id: id) { (response) in
            print(response)
        }
        
        
    }
    
    func editButtonTapped(sender: UIButton) {
        
        print(sender.tag)
        userModel = array[sender.tag]
        print("edit options")
        performSegue(withIdentifier: "EditUserSegue", sender: self)
    }
    
    func switchButtonTapped(sender: UISwitch) {
        
       let id = array[sender.tag].id
        print("enable disable options")
        
        
        var userStatus: Bool = false
        if sender.isOn {
          userStatus = false
       
        } else {
            
          userStatus = true
        }
        
        
        ToggleUserStatusPutService.executeRequest(id: id, status: userStatus) { (response) in
            print(response)
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditUserSegue" {
            
            let dvc = segue.destination as! EditUserTableViewController
            dvc.userModel = userModel
        }
    }
}
