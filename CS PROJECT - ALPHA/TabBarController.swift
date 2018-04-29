//
//  TabBarController.swift
//  CS PROJECT - ALPHA
//
//  Created by Anqi Lou on 2018/4/8.
//  Copyright © 2018年 Hansen Pen. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    var Username: String  = ""
    var Password: String = ""
    
    var backgroundName = ""
    
    



    override func viewDidLoad() {
        super.viewDidLoad()
        
        let selectedColor   = UIColor.init(red: 81/478, green: 137/478, blue: 260/478, alpha: 1)
        let unselectedColor = UIColor.gray
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: unselectedColor], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: selectedColor], for: .selected)
        
        self.tabBar.items![0].image = UIImage(named: "profile")?.withRenderingMode(.automatic)
        self.tabBar.items![1].image = UIImage(named: "record")?.withRenderingMode(.automatic)
        self.tabBar.items![2].image = UIImage(named: "explore")?.withRenderingMode(.automatic)
        
        let navController = self.viewControllers![0] as! UINavigationController
        let vc = navController.topViewController as! ProfileSceneViewController
        vc.profileBackground = backgroundName
        vc.Username = Username
        vc.Password = Password
        
        
        let navController2 =  self.viewControllers![1] as! UINavigationController
        let vc2 = navController2.topViewController as! RecordViewController
        vc2.Username = Username
        vc2.Password = Password
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    // MARK: - Navigation
    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
    }
    */

}
