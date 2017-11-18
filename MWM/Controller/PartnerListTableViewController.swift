//
//  PartnerListTableViewController.swift
//  MWM
//
//  Created by admin on 18/11/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import UIKit

class PartnerListTableViewController: BaseTableViewController, UISearchResultsUpdating, UISearchBarDelegate {
    
    let searchController = UISearchController(searchResultsController: nil)
    let user = LoginUtils.getCurrentUser()!
    var array: [PartnerModel] = []
    var filteredArray = [PartnerModel]()
    var categoryId: Int?
    var brandName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filteredArray = array
        
        let rightBarButton = UIBarButtonItem(title: "Add", style: UIBarButtonItemStyle.plain, target: self, action: #selector(PartnerListTableViewController.addPartnerSegue))
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        getCategory()
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
        
        
        
        
        
        
//        self.searchController.searchResultsUpdater = self
//        
//        self.searchController.hidesNavigationBarDuringPresentation = false
//        self.searchController.dimsBackgroundDuringPresentation = true
//        self.searchController.obscuresBackgroundDuringPresentation = false
//        
//        searchController.searchBar.sizeToFit()
//        searchController.searchBar.becomeFirstResponder()
//        self.navigationItem.titleView = searchController.searchBar
        
    }
    
    func addPartnerSegue() {
        
        performSegue(withIdentifier: "showAddPartnerSegue", sender: self)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PartnerTableViewCell
        
        cell.info = array[indexPath.row]
        
        return cell
    }
    
    func getCategory() {
        
        CategoryGetService.executeRequest { (response) in
            print(response)
            
            self.findCategoryId(categories: response)
        }
    }
    
    
    func findCategoryId(categories: [CategoryModel]) {
        
        for category in categories.enumerated() {
            
            if category.element.name == "MBKRestaurant" {
                brandName = category.element.name
                categoryId = category.element.id
                getPartnerList()
            }
        }
    }
    
    func getPartnerList() {
        
        let param = ["pageNumber": 0, "pageSize" : 10, "city": user.city!, "categoryId": categoryId!] as [String : Any]
        PartnerGetService.executeRequest(param) { (response) in
            
//            print(response)
            self.array = response
            self.tableView.reloadData()
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
//         If we haven't typed anything into the search bar then do not filter the results
        if searchController.searchBar.text! == "" {
            getPartnerList()
        } else {
            return
        }
    }
    
   
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        print("search from keyboard")
        
        let param = ["pageNumber": 0, "pageSize" : 10, "city": user.city!, "categoryId": categoryId!, "partnerName":searchBar.text!, "brandName": brandName] as [String : Any]
        PartnerGetService.executeRequest(param) { (response) in
            
            print(response)
            self.array = response
            self.tableView.reloadData()
        }
    }
}
