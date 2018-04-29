//
//  RestaurantsViewController.swift
//  CS PROJECT - ALPHA
//
//  Created by Hansen Pen on 4/8/18.
//  Copyright © 2018 Hansen Pen. All rights reserved.
//

import UIKit

class RestaurantsViewController: UIViewController,UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        self.searchBar.endEditing(true)
    }
    private func setUpSearchBar(){
        searchBar.delegate = self
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        var text = searchText
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
        let cell: RestaurantsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! RestaurantsTableViewCell
        let restaurant = currentRestaurantList[indexPath.row]
        cell.restaurantName.text = restaurant.name
        cell.operationHours.text = "open: \(restaurant.openHours!/100) am - \(restaurant.closeHours!/100-12) pm"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight(for: indexPath)
    }
    
    private func rowHeight(for indexPath: IndexPath) -> CGFloat {
        return 65
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let destinationVC = segue.destination as? FoodsViewController,
            let selectedIndexPath = table.indexPathForSelectedRow {
            destinationVC.foods = currentRestaurantList[selectedIndexPath.row].foods
            destinationVC.restaurant = currentRestaurantList[selectedIndexPath.row]
            destinationVC.entrees = currentRestaurantList[selectedIndexPath.row].foods.entree
            destinationVC.currentEntrees = currentRestaurantList[selectedIndexPath.row].foods.entree
            destinationVC.xsides = currentRestaurantList[selectedIndexPath.row].foods.sides
            destinationVC.currentSides = currentRestaurantList[selectedIndexPath.row].foods.sides
            destinationVC.dessert = currentRestaurantList[selectedIndexPath.row].foods.desserts
            destinationVC.currentDessert = currentRestaurantList[selectedIndexPath.row].foods.desserts
            
        }
        
    }

  
    @IBOutlet weak var hoursSelected: UITextField!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var searchActive: Bool = false
    
    
    var selectedHour: String?
    
    let restaurantList = dataModel.init().list
    var currentRestaurantList = dataModel.init().list
    
    let hours = [0,100,200,300,400,500,600,700,800,900,1000,1100,1200,1300,1400,1500,1600,1700,1800,1900,2000,2100,2200,2300,2400]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Restaurants"
        self.table.delegate = self
        self.table.dataSource = self
        setUpSearchBar()
        createHourPicker()
        createToolbar()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createHourPicker(){
        
        let hourPicker = UIPickerView()
        hourPicker.delegate = self
        
        hoursSelected.inputView = hourPicker
        
    }
    func createToolbar(){
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title:"Done", style: .plain, target: self, action: #selector(RestaurantsViewController.dismissKeyboard))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        hoursSelected.inputAccessoryView  = toolBar
        
        
    }
    @objc func dismissKeyboard(){
        view.endEditing(true)
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
extension RestaurantsViewController: UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return hours.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if hours[row] == 0{
            return String("-Selected-")
        }else{
            if hours[row] <= 1200{
                return String(hours[row] / 100) + ":00 AM"
            }else{
                return String(hours[row] / 100) + ":00 PM"
            }
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if hours[row] == 0{
            hoursSelected.text = ""
            currentRestaurantList = restaurantList
            table.reloadData()
        }else{
            if hours[row] <= 1200{
             selectedHour = String(hours[row] / 100) + ":00 AM"
            }else{
             selectedHour = String(hours[row] / 100) + ":00 PM"
      
        }

            hoursSelected.text = selectedHour
        
            currentRestaurantList = restaurantList.filter({restaurant  -> Bool in ((hours[row] >= restaurant.openHours!) && (hours[row] <= restaurant.closeHours!))
        
            })
            table.reloadData()
        
    
    }
    
    
    
    

}
}
