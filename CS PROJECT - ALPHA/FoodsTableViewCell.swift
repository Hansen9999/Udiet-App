//
//  FoodsTableViewCell.swift
//  CS PROJECT - ALPHA
//
//  Created by Hansen Pen on 4/17/18.
//  Copyright © 2018 Hansen Pen. All rights reserved.
//

import UIKit

class FoodsTableViewCell: UITableViewCell {

    @IBOutlet weak var foodsNAME: UILabel!
    @IBOutlet weak var foodsCalories: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
