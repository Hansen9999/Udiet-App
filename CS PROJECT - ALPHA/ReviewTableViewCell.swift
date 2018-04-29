//
//  ReviewTableViewCell.swift
//  CS PROJECT - ALPHA
//
//  Created by Hansen Pen on 4/11/18.
//  Copyright © 2018 Hansen Pen. All rights reserved.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var reviewContent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
