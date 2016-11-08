//
//  SectionTableViewCell.swift
//  request2.0
//
//  Created by yokesh on 11/8/16.
//  Copyright © 2016 yokesh. All rights reserved.
//

import UIKit

class SectionTableViewCell: UITableViewCell {

    @IBOutlet weak var SectionGagTitle: UILabel!
    @IBOutlet weak var SectionGagImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
