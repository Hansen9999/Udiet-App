//
//  RestaurantsTableViewCell.swift
//  CS PROJECT - ALPHA
//
//  Created by Anqi Lou on 2018/4/1.
//  Copyright © 2018年 Hansen Pen. All rights reserved.
//

import UIKit

class RestaurantsTableViewCell: UITableViewCell {

    @IBOutlet weak var restaurantName: UILabel!
    
    @IBOutlet weak var operationHours: UILabel!
    
    var restaurants = dataModel.init()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
