//
//  NutritionDetailViewController.swift
//  CS PROJECT - ALPHA
//
//  Created by Anqi Lou on 2018/4/4.
//  Copyright © 2018年 Hansen Pen. All rights reserved.
//

import UIKit

class NutritionDetailViewController: UIViewController {
    
    var item: Item?
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var calories: UILabel!
    @IBOutlet weak var fat: UILabel!
    @IBOutlet weak var carb: UILabel!
    @IBOutlet weak var protein: UILabel!
    @IBOutlet weak var cholesterol: UILabel!
    
    
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var caloriesIcon: UIImageView!
    @IBOutlet weak var fatIcon: UIImageView!
    @IBOutlet weak var carbIcon: UIImageView!
    @IBOutlet weak var proteinIcon: UIImageView!
    @IBOutlet weak var cholesterolIcon: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.name.text = item?.name
        self.calories.text = item?.calories
        self.fat.text = (item?.fat)! + "g"
        self.carb.text = (item?.carb)! + "g"
        self.protein.text = (item?.protein)! + "g"
        self.cholesterol.text = (item?.cholesterol)! + "mg"
        self.caloriesIcon.image = UIImage(named: "calories")
        self.fatIcon.image = UIImage(named: "fat")
        self.carbIcon.image = UIImage(named: "carbohydrates")
        self.proteinIcon.image = UIImage(named: "protein")
        self.cholesterolIcon.image = UIImage(named: "cholesterol")
        self.foodImage.image = UIImage(named: (item?.name)!)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
