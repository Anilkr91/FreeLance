//
//  AddPartnerTableViewController.swift
//  MWM
//
//  Created by admin on 18/11/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import UIKit

class AddPartnerTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rightBarButton = UIBarButtonItem(title: "Add", style: UIBarButtonItemStyle.plain, target: self, action: #selector(AddPartnerTableViewController.addPartnerSegue))
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func addPartnerSegue() {
        
        print("add patner segue")
    }
}
