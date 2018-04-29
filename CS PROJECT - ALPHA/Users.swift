//
//  Users.swift
//  CS PROJECT - ALPHA
//
//  Created by William on 4/7/18.
//  Copyright © 2018 Hansen Pen. All rights reserved.
//

import Foundation
import UIKit

class Users{
    var name: String?
    var email:String?
    var userCalories: Array<Any>
    var avaerageCalories: Int?
    var foodLists:Array<Any>
    var profilePhoto: UIImage?
    var font: UIFont?
    var background: UIImage?
    
    init(name: String, email: String) {
        self.name = name
        self.email = email
        self.userCalories = []
        self.avaerageCalories = 0
        self.foodLists = []
        self.profilePhoto = #imageLiteral(resourceName: "user")
        self.font = nil
        self.background = #imageLiteral(resourceName: "Background2")
        
        
    }
}
