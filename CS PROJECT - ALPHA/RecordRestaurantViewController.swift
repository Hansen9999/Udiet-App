//
//  RecordRestaurantViewController.swift
//  CS PROJECT - ALPHA
//
//  Created by Anqi Lou on 2018/4/9.
//  Copyright © 2018年 Hansen Pen. All rights reserved.
//

import UIKit

class RecordRestaurantViewController: UIViewController, UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource {
    var Username: String = ""
    var Password: String = ""

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var table: UITableView!
    
    let restaurantList = dataModel.init().list
    var currentRestaurantList = dataModel.init().list
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        self.searchBar.endEditing(true)
    }
    private func setUpSearchBar(){
        searchBar.delegate = self
    }
    
    @IBAction func cancel(_ sender: Any) {

    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        guard !searchText.isEmpty else{
            currentRestaurantList = restaurantList
            table.reloadData()
            return
        }
        currentRestaurantList = restaurantList.filter({restaurant  -> Bool in (restaurant.name?.contains(searchText))!
            
        })
        
        table.reloadData()
        
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentRestaurantList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier4", for: indexPath)
        let restaurant = currentRestaurantList[indexPath.row]
        cell.textLabel?.text = restaurant.name
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight(for: indexPath)
    }
    private func rowHeight(for indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.table.delegate = self
        self.table.dataSource = self
        setUpSearchBar()
        navigationItem.hidesBackButton = true
        navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.isHidden = true
        
        print(Username)
        print(Password)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "recordfood"{
            if let destinationVC = segue.destination as? RecordFoodViewController,
                let selectedIndexPath = table.indexPathForSelectedRow {
                destinationVC.foods = currentRestaurantList[selectedIndexPath.row].foods
                destinationVC.restaurant = currentRestaurantList[selectedIndexPath.row]
                destinationVC.Username = Username
                destinationVC.Password = Password
        }
        }
        if segue.identifier  == "restaurantback"{
            if let destinationVC = segue.destination as? RecordViewController{
                destinationVC.Username = Username
                destinationVC.Password = Password
                
            }
        }
    }


}
