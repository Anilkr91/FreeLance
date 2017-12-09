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
    var searchString: String = ""
    var partnerModel: PartnerModel?
    
    var currentPage = 0
    var totalElements = 0
    var isLoadMore: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCategory()
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
        cell.index = indexPath.row
        cell.info = array[indexPath.row]
        
        if cell.index == array.count - 1 {
            if totalElements >= array.count {
                
                loadMoreFooterView(count: array.count)
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        partnerModel  = array[indexPath.row]
        performSegue(withIdentifier: "showFeedbackSegue", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showFeedbackSegue" {
            let dvc = segue.destination as!  HomeViewController
            dvc.partnerModel = partnerModel
        }
    }
    
    
    func loadMorePartners(_ sender: LoadMoreTableViewCell) {
        print("load more tapped")
        //        isLoadMore = true
        
        self.currentPage = currentPage+1
        getPartnerList(pageNumber: currentPage)
        
    }
    func getCategory() {
        CategoryGetService.executeRequest { (response) in
            self.findCategoryId(categories: response)
        }
    }
    
    func findCategoryId(categories: [CategoryModel]) {
        
        for category in categories.enumerated() {
            
            if category.element.name == "MBKRestaurant" {
                brandName = category.element.name
                categoryId = category.element.id
                getPartnerList(pageNumber: currentPage)
            }
        }
    }
    
    func getPartnerList(pageNumber: Int) {
        
        let param = ["pageNumber": pageNumber, "pageSize" : 20, "region": user.region!, "categoryId": categoryId!] as [String : Any]
        PartnerGetService.executeRequest(param) { (response) in
            
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
        let param = ["pageNumber": 0, "pageSize" : 20, "region": user.region!, "categoryId": categoryId!, "partnerName":searchString, "brandName": brandName] as [String : Any]
        PartnerGetService.executeRequest(param) { (response) in
            
            print(response)
            self.array = response.data
            self.tableView.reloadData()
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        searchString = searchController.searchBar.text!
    }
    
    @IBAction func addPartnerButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "showAddPartnerSegue", sender: self)
    }
    
    @IBAction func refreshButtonTapped(_ sender: Any) {
        getPartnerList(pageNumber: currentPage)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        if searchString.removeAllSpaces().isEmpty {
            return
            
        } else {
            getPartnerList(pageNumber: currentPage)
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
