//
//  StartWorkingViewController.swift
//  MWM
//
//  Created by admin on 04/11/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class StartWorkingViewController: BaseViewController {
    
    @IBOutlet weak var startWorkingButton: UIButton!
    @IBOutlet weak var newEntryButton: UIButton!
    
    let user = LoginUtils.getCurrentUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setButtonTitle()
        startWorkingButton.addTarget(self, action: #selector(StartWorkingViewController.startWorking), for: .touchUpInside)
        newEntryButton.addTarget(self, action: #selector(StartWorkingViewController.startNewEntry), for: .touchUpInside)
    }

    func startNewEntry() {
       self.performSegue(withIdentifier: "showFeedbackSegue", sender: self)
        
    }

    func setButtonTitle() {
       
        if LoginUtils.getCurrentUserSession() == nil {
            startWorkingButton.setTitle("Start Working", for: .normal)
            newEntryButton.isHidden = true
            
        } else {
            startWorkingButton.setTitle("End Working", for: .normal)
            self.newEntryButton.isHidden = false
        }
    }
    
    func startWorking() {
        
        if LoginUtils.getCurrentUserSession() == nil {
            startWork()
            
        } else {
            endWork()
        }
    }
    
    func endWork() {
        
        let param = ["id": user?.sessionId]
        EndWorkingPostService.executeRequest( param, completionHandler: { (response) in
            LoginUtils.setCurrentUserSession(nil)
            self.startWorkingButton.setTitle("Start Working", for: .normal)
            self.newEntryButton.isHidden = true
        })
    }
    
    func startWork() {
        
        StartWorkingPostService.executeRequest { (response) in
            LoginUtils.setCurrentUserAttendence(response.data)
            LoginUtils.setCurrentUserSession(response.data.id)
           
            self.startWorkingButton.setTitle("End Working", for: .normal)
            self.newEntryButton.isHidden = false
            self.performSegue(withIdentifier: "showFeedbackSegue", sender: self)
        }
    }
}
