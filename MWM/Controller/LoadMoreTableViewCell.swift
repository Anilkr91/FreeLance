//
//  LoadMoreTableViewCell.swift
//  MWM
//
//  Created by admin on 02/12/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import UIKit

class LoadMoreTableViewCell: UITableViewCell {
    var index: Int!
    @IBOutlet weak var loadMoreButton: UIButton!
    var height: CGFloat = UITableViewAutomaticDimension
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        height = -1.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
