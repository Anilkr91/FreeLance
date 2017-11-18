//
//  PartnerListTableViewController.swift
//  MWM
//
//  Created by admin on 18/11/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import UIKit

class PartnerListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let rightBarButton = UIBarButtonItem(title: "Add", style: UIBarButtonItemStyle.plain, target: self, action: #selector(PartnerListTableViewController.addPartnerSegue))
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        getCategory()
//        getPartnerList()
    }

    func addPartnerSegue() {
        
        print("add patner segue")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return UITableViewCell()
    }
    
    func getCategory() {
        
        CategoryGetService.executeRequest { (response) in
            print(response)
        }
        
    }
    
    
    func getPartnerList() {
         let user = LoginUtils.getCurrentUser()!
        
//        let param = ["partnerName": "", "city": "", "categoryId": "", "brandName": ""]
        
        let param = ["city": user.city!]
        PartnerGetService.executeRequest(param) { (response) in
            print(response)
            
        }
        
    }
}
