//
//  CreateTaskTableViewController.swift
//  MWM
//
//  Created by admin on 16/12/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import UIKit
import SwiftDate

class CreateTaskTableViewController: UITableViewController {
    
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var assignedtoTextField: UITextField!
    @IBOutlet weak var assignedbyTextField: UITextField!
    @IBOutlet weak var partnerTextField: UITextField!
    @IBOutlet weak var dueDateTextField: UITextField!
    @IBOutlet weak var choosePriorityTextField: UITextField!

     let user = LoginUtils.getCurrentUser()!
     var userModel: UserListResponseModel?
    var partnerModel: PartnerModel?
    var selectedDate: Date?
    
     lazy var dateOfBirthDatePicker = UIDatePicker()
    
    
    lazy var picker = UIPickerView()
    let dateFormatter = "dd-MM-YYYY"
    let array = ["", "HIGH", "MEDIUM","LOW"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        dateOfBirthDatePicker.datePickerMode = .date
        dueDateTextField.inputView = dateOfBirthDatePicker
        
         dateOfBirthDatePicker.addTarget(self, action: #selector(CreateTaskTableViewController.getDate(sender:)), for: UIControlEvents.valueChanged)

        
        assignedbyTextField.text = user.userName
        
        choosePriorityTextField.inputView = picker
        picker.delegate = self
        
        assignedtoTextField.addTarget(self, action: #selector(CreateTaskTableViewController.showUsersList(_:)), for: .editingDidBegin)
        
        partnerTextField.addTarget(self, action: #selector(CreateTaskTableViewController.showPartnersList(_:)), for: .editingDidBegin)
        
        setupBarButton()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getDate(sender: Any) {
        self.selectedDate =  dateOfBirthDatePicker.date
        let dateString =  selectedDate?.string(custom: dateFormatter)
        dueDateTextField.text = dateString
    }
    
    func setupBarButton() {
        
        let rightBarButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(UsersListTableViewController.done))
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    func done() {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showUserListSegue" {
            
            let nvc = segue.destination as? UINavigationController
            let dvc = nvc?.viewControllers[0] as? UsersListTableViewController
            dvc?.delegate = self
            
            
        } else if segue.identifier == "showPartnerListSegue" {
            
            let nvc = segue.destination as? UINavigationController
            let dvc = nvc?.viewControllers[0] as? AllPartnersListTableViewController
            dvc?.delegate = self
            
        }
    }
    
    func showUsersList(_ sender: UITextField)  {
        
        self.performSegue(withIdentifier: "showUserListSegue", sender: self)
    }
    
    func showPartnersList(_ sender: UITextField) {
        
        self.performSegue(withIdentifier: "showPartnerListSegue", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 2
        
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
        
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        
        
        let task = taskNameTextField.text!
        let description = descriptionTextField.text!
        let assignedto = assignedtoTextField.text!
        let assignedby = assignedbyTextField.text!
        let partner = partnerTextField.text!
        let taskDueDate = dueDateTextField.text!
        let priority = choosePriorityTextField.text!
        
        
        if task.removeAllSpaces().isEmpty {
            showAlert(title: "Error", message: "Please fill Task Name")
            
            
        } else if description.removeAllSpaces().isEmpty {
            showAlert(title: "Error", message: "Please fill Description Name")
            
            
        } else if assignedto.removeAllSpaces().isEmpty {
            showAlert(title: "Error", message: "Please fill assignedto ")
            
        } else if assignedby.removeAllSpaces().isEmpty {
            
            showAlert(title: "Error", message: "Please fill assignedby")
            
        } else if partner.removeAllSpaces().isEmpty {
            
            showAlert(title: "Error", message: "Please fill partner")
            
        } else if taskDueDate.removeAllSpaces().isEmpty {
            
            
            showAlert(title: "Error", message: "Please fill taskDueDate")
        } else if priority.removeAllSpaces().isEmpty {
            
            showAlert(title: "Error", message: "Please fill priority")
            
        } else {
            
            print("ALL Done")
            let date: Double = selectedDate!.timeIntervalSince1970.rounded(toPlaces: 0)*1000
            
            var selecteduserName: String = ""
            var selectedPartnerId: Int?
            
            if let userModel =  userModel {
                
               selecteduserName = userModel.userName
            }
            
            if let partnerModel =  partnerModel {
                
                selectedPartnerId = partnerModel.id
            }
            
            let param = CreateTaskRequestModel(name: task, description: description, assignedBy: assignedby, assignedTo: selecteduserName, partnerIdList: [selectedPartnerId!], dueDate: Int(date), priority: priority).toJSON()
            
            CreateTaskPostService.executeRequest(param!, completionHandler: { (response) in                
                self.dismiss(animated: true, completion: nil)

            })
        }
    }
    
    func showAlert(title: String, message: String) {
        
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OK = UIAlertAction(title: "OK", style: .default, handler: nil )
        
        alertView.addAction(OK)
        self.present(alertView, animated: true, completion: nil)
    }
}


extension CreateTaskTableViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        
        return array.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return array[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        return choosePriorityTextField.text = array[row]
    }
}

extension Double {
    //    / Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    
    func truncate(places : Int)-> Double
    {
        return Double(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
    }
    
}

extension CreateTaskTableViewController:  UserDelegte {
    func sendUserDelegate(user: UserListResponseModel) {
        
        self.userModel = user
        assignedtoTextField.text = user.userName
    }
}


extension CreateTaskTableViewController :PartnerDelegte {
    
    func sendPartnerDelegate(partner: PartnerModel) {
        
        self.partnerModel = partner
        partnerTextField.text = partner.partnerName
    }
}
