//
//  UsersListTableViewCell.swift
//  MWM
//
//  Created by admin on 16/12/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import UIKit
import Kingfisher

class UsersListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mobileLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
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

extension UsersListTableViewCell {
    
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
