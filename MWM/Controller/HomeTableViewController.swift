//
//  HomeTableViewController.swift
//  Demo
//
//  Created by admin on 28/09/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import UIKit

class HomeTableViewController: BaseTableViewController {
    
    weak var pvc: HomeViewController?
    
    @IBOutlet weak var restaurantNameTextField: UITextField!
    @IBOutlet weak var contactPersonName: UITextField!
    @IBOutlet weak var contactNumber: UITextField!
    @IBOutlet weak var area: UITextField!
    @IBOutlet weak var natureOfVisitField: UITextField!
    @IBOutlet weak var statusTextfield: UITextField!
    @IBOutlet weak var onBoardTextfield: UITextField!
    @IBOutlet weak var visitingCardImageView: UIImageView!
    @IBOutlet weak var restaurantImageView: UIImageView!
    
    let natureOfVisitarray = ["Revisit", "New Visit"]
    let statusArray = ["Hot", "Warm", "Cold", "On Boarding"]
    let onBoardArray = ["Yes", "No"]
    
    lazy var naturePicker = UIPickerView()
    lazy var statusPicker = UIPickerView()
    lazy var onboardPicker = UIPickerView()
    let imagePickerController = UIImagePickerController()
    let restaurantTapGesture =  UITapGestureRecognizer()
    let visitingTapGesture =  UITapGestureRecognizer()
    
    var imagePicked = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        naturePicker.tag = 0
        statusPicker.tag = 1
        onboardPicker.tag = 2
        
        visitingCardImageView.tag = 0
        restaurantImageView.tag = 1
        
        natureOfVisitField.inputView = naturePicker
        statusTextfield.inputView = statusPicker
        onBoardTextfield.inputView = onboardPicker
        
        naturePicker.delegate = self
        statusPicker.delegate = self
        onboardPicker.delegate = self
        
        visitingCardImageView.isUserInteractionEnabled  = true
        restaurantImageView.isUserInteractionEnabled = true
        
        restaurantTapGesture.addTarget(self, action: #selector(HomeTableViewController.uploadRestaurantImage(_:)))
        restaurantImageView.addGestureRecognizer(restaurantTapGesture)
        
        visitingTapGesture.addTarget(self, action: #selector(HomeTableViewController.uploadVisitingImage(_:)))
        visitingCardImageView.addGestureRecognizer(visitingTapGesture)

    }
    
    func uploadRestaurantImage(_ sender: UITapGestureRecognizer) {
        
        let view = sender.view
        if let view = view {
            imagePicked = view.tag
            handleImageTapGestureRecognizer()
            
        }
    }
    
    func uploadVisitingImage(_ sender: UITapGestureRecognizer) {
        
        let view = sender.view
        if let view = view {
            imagePicked = view.tag
            handleImageTapGestureRecognizer()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 7 {
            return UITableViewAutomaticDimension
        } else {
            return 44
        }
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
                cell.selectionStyle = .none
    }
}

extension HomeTableViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView.tag == 0 {
            return natureOfVisitarray.count
        } else if pickerView.tag == 1 {
            return statusArray.count
        } else if onboardPicker.tag == 2 {
            return onBoardArray.count
        }
        return 1
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView.tag == 0 {
            return natureOfVisitarray[row]
        } else if pickerView.tag == 1 {
            return statusArray[row]
        } else if onboardPicker.tag == 2 {
            return onBoardArray[row]
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView.tag == 0 {
            return natureOfVisitField.text = natureOfVisitarray[row]
        } else if pickerView.tag == 1 {
            return statusTextfield.text = statusArray[row]
        }else if pickerView.tag == 2 {
            return onBoardTextfield.text = onBoardArray[row]
        }
    }
}

extension HomeTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func handleImageTapGestureRecognizer() {
        let imagePickerMenu = UIAlertController(title: "upload", message: nil, preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Take photo", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            
            self.imagePickerController.sourceType = .camera
            self.imagePickerController.cameraDevice = .rear
            self.presentImagePickerController()
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        imagePickerMenu.addAction(cameraAction)
        imagePickerMenu.addAction(cancelAction)
        self.present(imagePickerMenu, animated: true, completion: nil)
    }
    
    func presentImagePickerController() {
        self.imagePickerController.delegate = self
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        ProgressBarView.showHUD()
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.imagePickerController.dismiss(animated: true, completion: nil)
        
        if let imageData = image?.jpeg(.medium) {
            UploadImagePostService.executeRequest(imageData, completionHandler: { (response) in
                ProgressBarView.hideHUD()
                if self.imagePicked == 0 {
                    self.pvc?.visitingCardImageUrl = response.data 
                    self.visitingCardImageView.image = image
                    
                } else {
                    self.pvc?.restaurantImageUrl = response.data
                    self.restaurantImageView.image = image
                    
                }
            })
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
