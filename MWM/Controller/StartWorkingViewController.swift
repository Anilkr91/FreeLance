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
        setupBarButton()
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

extension StartWorkingViewController {
    
    func setupBarButton() {
        let barButton = UIBarButtonItem()
        barButton.tintColor = UIColor.darkGray
        barButton.image = UIImage(named: "SettingIcon")
        barButton.target = self
        barButton.action = #selector(self.logout(_:))
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    func logout(_ sender: Any) {
        
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        // create an action
        let firstAction: UIAlertAction = UIAlertAction(title: "Logout", style: .default) { action -> Void in
            
            LogoutGetService.executeRequest { (data) in
                Alert.showAlertWithMessage("Success", message: "User logged out Successfully")
            }
            LoginUtils.setCurrentUserLogin(nil)
            let application = UIApplication.shared.delegate as! AppDelegate
            application.setHomeGuestAsRVC()
        }
        
        let secondAction: UIAlertAction = UIAlertAction(title: "Change Password", style: .default) { action -> Void in
            self.performSegue(withIdentifier: "showChangePasswordSegue", sender: self)
        }
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in }
        // add actions
        actionSheetController.addAction(firstAction)
        actionSheetController.addAction(secondAction)
        actionSheetController.addAction(cancelAction)
        
        // present an actionSheet...
        actionSheetController.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        present(actionSheetController, animated: true, completion: nil)
    }
}
