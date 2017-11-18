//
//  PartnerListTableViewController.swift
//  MWM
//
//  Created by admin on 18/11/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import UIKit

class PartnerListTableViewController: BaseTableViewController {
    
    
    var array: [PartnerModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let rightBarButton = UIBarButtonItem(title: "Add", style: UIBarButtonItemStyle.plain, target: self, action: #selector(PartnerListTableViewController.addPartnerSegue))
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        getCategory()
//        getPartnerList()
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
                getPartnerList(categoryId: category.element.id)
            }
        }
    }
    
    func getPartnerList(categoryId: Int) {
         let user = LoginUtils.getCurrentUser()!
        
        let param = ["pageNumber": 0, "pageSize" : 10, "city": user.city!, "categoryId": categoryId] as [String : Any]
        PartnerGetService.executeRequest(param) { (response) in

            print(response)
            
            self.array = response
            self.tableView.reloadData()
        }
    }
}
