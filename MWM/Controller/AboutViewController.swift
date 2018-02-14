//
//  AboutViewController.swift
//  MWM
//
//  Created by admin on 20/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import UIKit

class AboutViewController: BaseViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

         setupBarButton()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        hideSideMenuView()
    }
    
    func setupBarButton() {
        menuButton.target = self
        menuButton.action = #selector(toggleSideMenuView)
    }
}
