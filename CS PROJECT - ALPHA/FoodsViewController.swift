//
//  FoodsViewController.swift
//  CS PROJECT - ALPHA
//
//  Created by Anqi Lou on 2018/4/1.
//  Copyright © 2018年 Hansen Pen. All rights reserved.
//

import UIKit
import MapKit


class FoodsViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    var tableTag : Int = 0
    
    @IBAction func xSegment(_ sender: UISegmentedControl) {
        
     
        if sender.selectedSegmentIndex == 0{
            tableTag = 0
            print("12313123")
            calories.text = ""
            currentEntrees = entrees
            tableView.reloadData()
            
        }
        if sender.selectedSegmentIndex == 1{
            tableTag = 1
            print("1231230123-1")
            calories.text = ""
            currentSides = xsides
            tableView.reloadData()
            
        }
        if sender.selectedSegmentIndex == 2{
            tableTag = 2
            print("999")
            calories.text = ""
            currentDessert = dessert
            tableView.reloadData()
            
        }
    }
    struct ResponseDescriptor: Decodable {
        let message: String
        let status: Int
        let reviews: [Review]
    }
    
    struct Review: Decodable {
        let id: Int
        let content: String
    }
   

    @IBOutlet weak var calories: UITextField!
    var reviewList = [String]()
    let urlCondition = NSCondition()
    
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    

    var restaurant: Restaurant?
    var foods:Food?
    var entrees: [Item] = []
    var currentEntrees:[Item] = []
    var xsides:[Item] = []
    var currentSides:[Item] = []
    var dessert: [Item] = []
    var currentDessert: [Item] = []
    
    /*
    var entreeList =
    var currentfoods: Food?
    */
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        calories.resignFirstResponder()
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.calories.delegate = self
        self.title = restaurant?.name
        self.tableView.delegate = self
        self.tableView.dataSource = self

        //getReviewList()
        createCaloriePicker()
        createToolbar()
       
        
       



        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    let CaloriesList = [-1,0,300,600]
    var selectedCalories: String?
    
    func createCaloriePicker(){
        
        let caloriePicker = UIPickerView()
        caloriePicker.delegate = self
        
        calories.inputView = caloriePicker
        
    }
    func createToolbar(){
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title:"Done", style: .plain, target: self, action: #selector(FoodsViewController.dismissKeyboard))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        calories.inputAccessoryView  = toolBar
        
        
    }
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    @IBAction func Path(_ sender: UIButton) {
        if restaurant?.name == "Jester Java"{
            let latitude:CLLocationDegrees = 30.283098
            let longitude: CLLocationDegrees = -97.736948
            
            let regionDistance : CLLocationDistance = 1000;
            let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
            let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
            
            let Options = [MKLaunchOptionsMapCenterKey:NSValue(mkCoordinate: regionSpan.center),MKLaunchOptionsMapSpanKey: NSValue(mkCoordinate: regionSpan.center)]
            
            let placemark = MKPlacemark(coordinate: coordinates)
            let mapItem = MKMapItem(placemark: placemark)
            mapItem.name = "Jester Java"
            mapItem.openInMaps(launchOptions: Options)
            
            
            
        }
        if restaurant?.name == "Jester City Limit"{
            let latitude:CLLocationDegrees = 30.283098
            let longitude: CLLocationDegrees = -97.736948
            
            let regionDistance : CLLocationDistance = 1000;
            let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
            let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
            
            let Options = [MKLaunchOptionsMapCenterKey:NSValue(mkCoordinate: regionSpan.center),MKLaunchOptionsMapSpanKey: NSValue(mkCoordinate: regionSpan.center)]
            
            let placemark = MKPlacemark(coordinate: coordinates)
            let mapItem = MKMapItem(placemark: placemark)
            mapItem.name = "Jester City Limit"
            mapItem.openInMaps(launchOptions: Options)
            
            
            
        }
        if restaurant?.name == "Jester Second Floor Dining"{
            let latitude:CLLocationDegrees = 30.283098
            let longitude: CLLocationDegrees = -97.736948
            
            let regionDistance : CLLocationDistance = 1000;
            let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
            let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
            
            let Options = [MKLaunchOptionsMapCenterKey:NSValue(mkCoordinate: regionSpan.center),MKLaunchOptionsMapSpanKey: NSValue(mkCoordinate: regionSpan.center)]
            
            let placemark = MKPlacemark(coordinate: coordinates)
            let mapItem = MKMapItem(placemark: placemark)
            mapItem.name = "Jester Second Floor Dining"
            mapItem.openInMaps(launchOptions: Options)
            
            
            
        }
        if restaurant?.name == "Kinsolving Dining"{
            let latitude:CLLocationDegrees = 30.285839
            let longitude: CLLocationDegrees = -97.734073
            
            let regionDistance : CLLocationDistance = 1000;
            let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
            let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
            
            let Options = [MKLaunchOptionsMapCenterKey:NSValue(mkCoordinate: regionSpan.center),MKLaunchOptionsMapSpanKey: NSValue(mkCoordinate: regionSpan.center)]
            
            let placemark = MKPlacemark(coordinate: coordinates)
            let mapItem = MKMapItem(placemark: placemark)
            mapItem.name = "Kinsolving Dining"
            mapItem.openInMaps(launchOptions: Options)
        }
        if restaurant?.name == "Littlefield Patio Cafe"{
            let latitude:CLLocationDegrees = 30.289496
            let longitude: CLLocationDegrees = -97.739449
            
            let regionDistance : CLLocationDistance = 1000;
            let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
            let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
            
            let Options = [MKLaunchOptionsMapCenterKey:NSValue(mkCoordinate: regionSpan.center),MKLaunchOptionsMapSpanKey: NSValue(mkCoordinate: regionSpan.center)]
            
            let placemark = MKPlacemark(coordinate: coordinates)
            let mapItem = MKMapItem(placemark: placemark)
            mapItem.name = "Littlefield Patio Cafe"
            mapItem.openInMaps(launchOptions: Options)
        }
        if restaurant?.name == "Cypress Bend at San Jacinto"{
            let latitude:CLLocationDegrees = 30.283138
            let longitude: CLLocationDegrees = -97.734454
            
            let regionDistance : CLLocationDistance = 1000;
            let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
            let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
            
            let Options = [MKLaunchOptionsMapCenterKey:NSValue(mkCoordinate: regionSpan.center),MKLaunchOptionsMapSpanKey: NSValue(mkCoordinate: regionSpan.center)]
            
            let placemark = MKPlacemark(coordinate: coordinates)
            let mapItem = MKMapItem(placemark: placemark)
            mapItem.name = "Cypress Bend at San Jacinto"
            mapItem.openInMaps(launchOptions: Options)
        }
        
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        /*
        if let destinationVC = segue.destination as? NutritionDetailViewController{
            destinationVC.item = Item(name:"Bulgogi Barbecue Beef Strips", calories:406, fat:24.5, carb:19.7, protein:25.7, cholesterol:62.2)
        }
        */
        print(reviewList)
        if segue.identifier == "showdetail"{
            if tableTag == 0{
                if let destinationVC = segue.destination as? NutritionDetailViewController,
                    let selectedIndexPath = tableView.indexPathForSelectedRow {
                    destinationVC.item = currentEntrees[selectedIndexPath.row]
            }
        }
            if tableTag == 1{
            if let destinationVC = segue.destination as? NutritionDetailViewController,
                let selectedIndexPath = tableView.indexPathForSelectedRow {
                destinationVC.item = currentSides[selectedIndexPath.row]
            }
        }
            if tableTag == 2{
                if let destinationVC = segue.destination as? NutritionDetailViewController,
                    let selectedIndexPath = tableView.indexPathForSelectedRow {
                    destinationVC.item = currentDessert[selectedIndexPath.row]
                
            }
        }
        }
        if segue.identifier == "Comments"{
            print("before asyn task")
            getReviewList()
            
            print("after call asyn task")
            print(reviewList)
            if let destinationVC = segue.destination as? ReviewPageViewController{
                //print(reviewList)
                destinationVC.reviewList = reviewList
                destinationVC.restaurant = restaurant
                //print(destinationVC.reviewList)
            }
            
        }
 
    }


    
    func getReviewList(){
        let myActivityIndicator =  UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        myActivityIndicator.center = view.center
        
        myActivityIndicator.hidesWhenStopped = false
        myActivityIndicator.stopAnimating()
        
        view.addSubview(myActivityIndicator)
        
        
        let myUrl = URL(string: "http://54.244.61.231:8080/restaurant/review/list")
        var request = URLRequest(url:myUrl!)
        request.httpMethod = "POST"// Compose a query string
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        
        let postString = ["restaurant_name": restaurant?.name
            ] as! [String: String]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: postString, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
            displayMessage(userMessage: "Something went wrong. Try again.")
            return
        }
        
        let task1 = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            self.removeActivityIndicator(activityIndicator: myActivityIndicator)
            
            if error != nil
            {
                self.displayMessage(userMessage: "1")
                print("error=\(String(describing: error))")
                return
            }
            
            
            //Let's convert response sent from a server side code to a NSDictionary object:
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                
                guard let data = data else {
                    print("error - error getting data")
                    return
                }
                let responseDescriptor = try JSONDecoder().decode(FoodsViewController.ResponseDescriptor.self, from: data)
                
                // check status code
                let status = responseDescriptor.status
                if status != 0
                {
                    
                    self.displayMessage(userMessage: "Could not successfully perform this request. Please try again later")
                    return
                }
                
                    // Display an Alert dialog with a friendly error message
                    
                DispatchQueue.global().async {
                    let reviewList = responseDescriptor.reviews
                    print("complete: after get review list")
                    print(reviewList)
                    
                    
                    // case 1: empty reviewList
                    // case 2: has content -> then for loop, store contents in a single list called reviews
                    var reviews = [String]()
                    for review in reviewList {
                        if review == nil{
                            print("Empty review")
                        }
                        else{
                            reviews.append(review.content)
                        }
                    }
                    
                    self.reviewList = reviews
                    
                    print("HAHAHAHAHAHHAHAHA")
                    print(self.reviewList)
                    print("realse lock")
                    
                    self.urlCondition.signal()
                    self.urlCondition.unlock()
                        /*
                        let dataReviewArray  = parseJSON["reviews"] as? [Any]
                        for element in dataReviewArray! {
                            let dict = element as? [String: String]
                            let review = dict?["content"]
                            print(review);
                        }
                        */
 
                    }
            } catch {
                
                //Display an Alert dialog with a friendly error message
                self.displayMessage(userMessage: "Could not successfully perform this request. Please try again later")
                
                self.removeActivityIndicator(activityIndicator: myActivityIndicator)
                
                // Display an Alert dialog with a friendly error message
                self.displayMessage(userMessage: "Could not successfully perform this request. Please try again later")
                print(error)
            }
            
            
        }
        
        print("lock - main thread sleeps");
        self.urlCondition.lock()
        task1.resume()
        self.urlCondition.wait()
        self.urlCondition.unlock()
    }
        
    func removeActivityIndicator(activityIndicator: UIActivityIndicatorView)
    {
        DispatchQueue.main.async
            {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
        }
    }
    
    func displayMessage(userMessage:String) -> Void{
        DispatchQueue.main.async{
            let alertController = UIAlertController(title:"Alert", message:userMessage, preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title:"OK", style: .default)
            {(action:UIAlertAction!) in
                print("OK button tapped")
                DispatchQueue.main.async{
                    self.dismiss(animated:true,completion: nil)
                }
            }
            alertController.addAction(OKAction)
            self.present(alertController, animated:true,completion:nil)
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableTag == 0{
            return currentEntrees.count
        }
        if tableTag == 1{
            return currentSides.count
        }
        if tableTag == 2{
            return currentDessert.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "foodcell", for: indexPath)
        
        if tableTag == 0{
            cell.textLabel?.text = currentEntrees[indexPath.row].name
        }
        if tableTag == 1{
            cell.textLabel?.text = currentSides[indexPath.row].name
        }
        if tableTag == 2{
            cell.textLabel?.text = currentDessert[indexPath.row].name
        }
        return cell
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

extension FoodsViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return CaloriesList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if CaloriesList[row] == 0{
            return "Between" + " " + String(CaloriesList[row]) + " " + "and 300"
        }
        else{
            if CaloriesList[row] == 300{
                return "Between" + " " + String(CaloriesList[row]) + " " + "and 600"
            }
            else{
                if CaloriesList[row] == 600{
                    return "Greater than" + " " + String(CaloriesList[row])
                }else{
                        return "-Selected-"
                    }
            }
        }

    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if CaloriesList[row] == -1{
            calories.text = ""
            if tableTag == 0{
                currentEntrees = entrees
                tableView.reloadData()
            }
            if tableTag == 1{
                currentSides = xsides
                tableView.reloadData()
            }
            if tableTag == 2{
                currentDessert = dessert
                tableView.reloadData()
            }
        }
        
        if CaloriesList[row] == 0{
            calories.text = "Between" + " " + String(CaloriesList[row]) + " " + "and 300"
            if tableTag == 0{
                var helpEntrees: [Item] = []
                for i in 0...entrees.count - 1{
                    if (Int(entrees[i].calories!)!) < 300 && (Int(entrees[i].calories!)!) > 0{
                        helpEntrees.append(entrees[i])
                        
                    }
                    
                }
                currentEntrees = helpEntrees
                
                tableView.reloadData()
                
            }
            if tableTag == 1{
                var helpSides: [Item] = []
                for i in 0...xsides.count - 1{
                    if (Int(xsides[i].calories!)!) < 300 && (Int(xsides[i].calories!)!) > 0{
                        helpSides.append(xsides[i])
                        
                    }
                    
                }
                currentSides = helpSides
                
                tableView.reloadData()
                
            
                
            }
            if tableTag == 2{
                var helpDessert: [Item] = []
                for i in 0...dessert.count - 1{
                    if (Int(xsides[i].calories!)!) < 300 && (Int(dessert[i].calories!)!) > 0{
                        helpDessert.append(dessert[i])
                        
                    }
                    
                }
                currentDessert = helpDessert
                
                tableView.reloadData()
                
            }
            
        }

        else{
            if CaloriesList[row] == 300{
                calories.text = "Between" + " " + String(CaloriesList[row]) + " " + "and 600"
                if tableTag == 0{
                    var helpEntrees: [Item] = []
                    for i in 0...entrees.count - 1{
                        if (Int(entrees[i].calories!)!) < 600 && (Int(entrees[i].calories!)!) > 300{
                            helpEntrees.append(entrees[i])
                            
                        }
                        
                    }
                    currentEntrees = helpEntrees
                    
                    tableView.reloadData()
                    
                }
                if tableTag == 1{
                    var helpSides: [Item] = []
                    for i in 0...xsides.count - 1{
                        if (Int(xsides[i].calories!)!) < 600 && (Int(xsides[i].calories!)!) > 300{
                            helpSides.append(xsides[i])
                            
                        }
                        
                    }
                    currentSides = helpSides
                    
                    tableView.reloadData()
                    
                    
                    
                }
                if tableTag == 2{
                    var helpDessert: [Item] = []
                    for i in 0...dessert.count - 1{
                        if (Int(xsides[i].calories!)!) < 300 && (Int(dessert[i].calories!)!) > 0{
                            helpDessert.append(dessert[i])
                            
                        }
                        
                    }
                    currentDessert = helpDessert
                    
                    tableView.reloadData()
                    
                }
   
            
            
        }
        else{
            if CaloriesList[row] == 600 {
                calories.text = "Greater than" + " " + String(CaloriesList[row])
                if tableTag == 0{
                    var helpEntrees: [Item] = []
                    for i in 0...entrees.count - 1{
                        if (Int(entrees[i].calories!)!) > 600{
                            helpEntrees.append(entrees[i])
                            
                        }
                        
                    }
                    currentEntrees = helpEntrees
                    
                    tableView.reloadData()
                    
                }
                if tableTag == 1{
                    var helpSides: [Item] = []
                    for i in 0...xsides.count - 1{
                        if (Int(xsides[i].calories!)!) > 600{
                            helpSides.append(xsides[i])
                            
                        }
                        
                    }
                    currentSides = helpSides
                    
                    tableView.reloadData()
                    
                    
                    
                }
                if tableTag == 2{
                    var helpDessert: [Item] = []
                    for i in 0...dessert.count - 1{
                        if (Int(xsides[i].calories!)!) < 300 && (Int(dessert[i].calories!)!) > 0{
                            helpDessert.append(dessert[i])
                            
                        }
                        
                    }
                    currentDessert = helpDessert
                    
                    tableView.reloadData()
                    
                }
        
        
        
    }
    
    
    

    
}

}
}
}
