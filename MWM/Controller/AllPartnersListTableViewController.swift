//
//  AllPartnersListTableViewController.swift
//  MWM
//
//  Created by admin on 16/12/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import UIKit

protocol PartnerDelegte {
    func sendPartnerDelegate(partner: PartnerModel)
}

class AllPartnersListTableViewController: BaseTableViewController {
    
    
    var delegate: PartnerDelegte?
    
    let searchController = UISearchController(searchResultsController: nil)
    let user = LoginUtils.getCurrentUser()!
    var array: [PartnerModel] = []
    var filteredArray = [PartnerModel]()
    
    var brandName: String = ""
    var searchString: String = ""
    var partnerModel: PartnerModel?
    
//    var currentPage = 0
//    var totalElements = 0
//    var isLoadMore: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCategory()

    }
    
    func getCategory() {
        CategoryGetService.executeRequest { (response) in
            self.findCategoryId(categories: response)
        }
        
        
        let categories = LoginUtils.getCurrentUserCategoryList()!
        
        print(categories)
        
    }
    
    func findCategoryId(categories: [CategoryModel]) {
        
        var categoryIds: String = ""
        
        for category in categories.enumerated() {
            categoryIds += ",\(category.element.id)"
        }
        
        _ = categoryIds.remove(at: categoryIds.startIndex)
        
        showPartnersList(categoryIds: categoryIds)
        
    }
    
    func showPartnersList(categoryIds: String) {
        let param = ["pageNumber" : 0, "pageSize": 10, "categoryIds": categoryIds] as [String : Any]
        
        AllPartnerGetService.executeRequest(param) { (response) in
            print(response)
            self.array = response
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
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return array.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AllPartnersTableViewCell
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
        partnerModel = array[indexPath.row]
        
        self.dismiss(animated: true) {
            self.delegate?.sendPartnerDelegate(partner: self.partnerModel!)
        }
    }
}
