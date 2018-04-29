//
//  SettingPreferrencesViewController.swift
//  CS PROJECT - ALPHA
//
//  Created by William on 4/8/18.
//  Copyright © 2018 Hansen Pen. All rights reserved.
//

import UIKit

class SettingPreferrencesViewController: UIViewController {

    
    @IBOutlet weak var LabelMessage: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LabelMessage.text = "Sorry, this page is currently under development \(Emoji.sadFace)"
        tabBarController?.tabBar.isHidden = true
        navigationItem.hidesBackButton = false
        navigationController?.isNavigationBarHidden = false


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
