//
//  Foods.swift
//  CS PROJECT - ALPHA
//
//  Created by Anqi Lou on 2018/4/1.
//  Copyright © 2018年 Hansen Pen. All rights reserved.
//

import Foundation


class Item{
    var name: String?
    var calories: String?
    var fat: String?
    var carb: String?
    var protein: String?
    var cholesterol: String?
    
    init(name: String, calories: String, fat: String, carb: String, protein: String, cholesterol: String) {
        self.name = name
        self.calories = calories
        self.fat = fat
        self.carb = carb
        self.protein = protein
        self.cholesterol = cholesterol
    }
}

class Food{
    public var entree: [Item]
    public var sides: [Item]
    public var desserts: [Item]
    
    init(entree:[Item], sides: [Item], desserts: [Item]){
        self.entree = entree
        self.sides = sides
        self.desserts = desserts
    }
}
