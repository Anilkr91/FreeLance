//
//  MyUsersListTableViewCell.swift
//  MWM
//
//  Created by admin on 06/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import UIKit
import Kingfisher

class MyUsersListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mobileLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var switchButton: UISwitch!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    var info: UserListResponseModel? {
        didSet {
            if let member = info {
                didSetCategory(member)
            }
        }
    }
}

extension MyUsersListTableViewCell {
    
    func didSetCategory(_ info: UserListResponseModel) {
        
        let placeholderImage = UIImage(named: "attendence")
        if let url = info.profilePicture {
            let imageUrl = URL(string: url)
            userImageView.kf.setImage(with: imageUrl, placeholder: placeholderImage)
            
        } else {
            userImageView.image = placeholderImage
        }
        nameLabel.text = info.name
        mobileLabel.text = info.mobileNo
        addressLabel.text = info.region
    }
}
