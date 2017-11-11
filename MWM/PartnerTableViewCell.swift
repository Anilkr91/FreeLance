//
//  PartnerTableViewCell.swift
//  MWM
//
//  Created by admin on 11/11/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import UIKit

class PartnerTableViewCell: UITableViewCell {

    @IBOutlet weak var partnerImageView: UIImageView!
    @IBOutlet weak var partnerLocalityLabel: UILabel!
    @IBOutlet weak var partnerStateLabel: UILabel!
    @IBOutlet weak var partnerAddressLabel: UILabel!
    @IBOutlet weak var checkInButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
