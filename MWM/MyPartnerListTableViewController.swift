//
//  MyPartnerListTableViewController.swift
//  MWM
//
//  Created by admin on 06/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import UIKit

class MyPartnerListTableViewController: BaseTableViewController, UISearchResultsUpdating, UISearchBarDelegate {
   
    
    let searchController = UISearchController(searchResultsController: nil)
    let user = LoginUtils.getCurrentUser()!
    var array: [PartnerModel] = []
    var filteredArray = [PartnerModel]()
    
    var brandName: String = ""
    var searchString: String = ""
    var categoryIds: String = ""
    var partnerModel: PartnerModel?
    
        var currentPage = 0
        var totalElements = 0
        var isLoadMore: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        findCategoryId()
         filteredArray = array
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
    
    @IBAction func addPartnerButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "showAddPartnerSegue", sender: self)
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
    
    
    func findCategoryId() {
        
        let categories = LoginUtils.getCurrentUserCategoryList()!
        
        for category in categories.enumerated() {
            categoryIds += ",\(category.element)"
        }
        _ = categoryIds.remove(at: categoryIds.startIndex)
        
        showPartnersList(pageNumber: currentPage)
    }
    
    func showPartnersList(pageNumber: Int) {
        let param = ["pageNumber" : pageNumber, "pageSize": 20, "categoryIds": categoryIds] as [String : Any]
        
        AllPartnerGetService.executeRequest(param) { (response) in
                       
            self.totalElements =  response.totalElements
            
            if pageNumber == 0 {
                self.array = response.data
            } else {
                self.array += response.data
            }
            self.tableView.reloadData()
        }
    }
    
    
    func searchPartnerList(searchString: String) {
        let param = ["pageNumber": 0, "pageSize" : 20, "region": user.region!, "categoryId": categoryIds, "partnerName":searchString, "brandName": brandName] as [String : Any]
       
        AllPartnerGetService.executeRequest(param) { (response) in
           
            self.array = response.data
            self.tableView.reloadData()
        }
    }
    
    func setupBarButton() {
        
        let rightBarButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(AllPartnersListTableViewController.done))
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    func done() {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MyPartnerTableViewCell
        cell.index = indexPath.section
        cell.info = array[indexPath.section]
        
        if cell.index == array.count - 1 {
            if totalElements >= array.count {
                
                loadMoreFooterView(count: array.count)
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
        partnerModel = array[indexPath.section]
    
    }
    
    func loadMorePartners(_ sender: LoadMoreTableViewCell) {
        print("load more tapped")
       
        
        self.currentPage = currentPage+1
        
        showPartnersList(pageNumber: currentPage)
//        getPartnerList(pageNumber: currentPage)
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        searchString = searchController.searchBar.text!
    }
    
   
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        if searchString.removeAllSpaces().isEmpty {
            return
            
        } else {
            showPartnersList(pageNumber: currentPage)
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
        if searchString.removeAllSpaces().isEmpty {
            return
            
        } else {
            searchPartnerList(searchString: searchBar.text!)
        }
    }
    
    
}
