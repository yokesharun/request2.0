//
//  ActivityTableViewCell.swift
//  request2.0
//
//  Created by yokesh on 11/6/16.
//  Copyright © 2016 yokesh. All rights reserved.
//

import UIKit

class ActivityTableViewCell: UITableViewCell {

    @IBOutlet weak var activityTimeAgo: UILabel!
    @IBOutlet weak var activityContent: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var gagImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
