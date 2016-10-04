//
//  PostTableViewCell.swift
//  request2.0
//
//  Created by yokesh on 10/4/16.
//  Copyright © 2016 yokesh. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var newImage: UIImageView!
        @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {

       
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
