//
//  RecordViewController.swift
//  CS PROJECT - ALPHA
//
//  Created by Anqi Lou on 2018/4/9.
//  Copyright © 2018年 Hansen Pen. All rights reserved.
//

import UIKit

class RecordViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    struct ResponseDescriptor: Decodable {
        let message: String
        let status: Int
        let info: info
    }
    
    struct info: Decodable {
        let calories:[calories]
        let name: String
        let today_foods: [today_foods]
    }
    
    struct today_foods: Decodable{
        let foods: [String]
        let restaurant : String
    }
    
    struct calories: Decodable{
        let id: Int
        let calorie: Float
        let date:String
    }

    let restaurantList = dataModel.init().list

    let urlCondition = NSCondition()
    
    var Username: String = ""
    var Password: String = ""

    @IBOutlet weak var totalCalories: UILabel!
    
    var datalist: Array<Any> = []
    
    var foodsDictionary: Dictionary = [String:[Any]]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.isHidden = false
        
        print(Username)
        print(Password)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        getData()
        totalCalories.text = String(getTotalCalories())
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func record(_ sender: Any) {


    }
    
    
    func getData(){
        
        let myActivityIndicator =  UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        myActivityIndicator.center = view.center
        
        myActivityIndicator.hidesWhenStopped = false
        myActivityIndicator.stopAnimating()
        
        view.addSubview(myActivityIndicator)
        
        
        let myUrl = URL(string: "http://54.244.61.231:8080/user/info")
        var request = URLRequest(url:myUrl!)
        request.httpMethod = "POST"// Compose a query string
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        
        let postString = ["username":Username,
                          "password":Password
        ] as! [String:String]
        
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
                let responseDescriptor = try JSONDecoder().decode(RecordViewController.ResponseDescriptor.self, from: data)
                
                // check status code
                let status = responseDescriptor.status

                if status != 0
                {
                    
                    self.displayMessage(userMessage: "Could not successfully perform this request. Please try again later")
                    return
                }
                
                // Display an Alert dialog with a friendly error message
                
                DispatchQueue.global().async {
                    let info = responseDescriptor.info as? info
                    let y = info?.today_foods as? [today_foods]
                    if y?.count != 0{
                        let list = y![0].foods
                        let restname = y![0].restaurant
                        
                        
                        for elements in y!{
                            self.foodsDictionary[elements.restaurant] = elements.foods
                            
                            
                        }
                        print (self.foodsDictionary)
                        print(list)
                        print(restname)
                        print("complete: after get review list")
                    }
                    
                    
           
                    
                    
                    // case 1: empty reviewList
                    // case 2: has content -> then for loop, store contents in a single list called reviews
                    
                    /*
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
                    */
                    
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
    
        
        
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "recordrestaurant"{
            if let destinationVC = segue.destination as? RecordRestaurantViewController{
                destinationVC.Username = Username
                destinationVC.Password = Password
            }

            
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.foodsDictionary.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Array(foodsDictionary)[section].key
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let items = Array(foodsDictionary)[section].value
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FoodsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "foodcell", for: indexPath) as! FoodsTableViewCell
        let items = Array(foodsDictionary)[indexPath.section].value
        let caloriesList = getCalories(foodsList: items as! Array<String>, restaurant: Array(foodsDictionary.keys)[indexPath.section])
        cell.foodsNAME.text = items[indexPath.row] as! String
        cell.foodsCalories.text = caloriesList[indexPath.row]
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight(for: indexPath)
    }
    
    private func rowHeight(for indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func getCalories(foodsList: Array<String>, restaurant: String) -> [String]{
        var currentRestaurant: Restaurant?
        var caloriesList: [String] = [String]()
        for element in restaurantList{
            if element.name == restaurant{
                currentRestaurant = element
            }
        }
        for item in (currentRestaurant?.foods.entree)!{
            for i in foodsList{
                if item.name == i{
                    caloriesList.append(item.calories!)
                }
            }
        }
        for item in (currentRestaurant?.foods.sides)!{
            for i in foodsList{
                if item.name == i{
                    caloriesList.append(item.calories!)
                }
            }
        }
        for item in (currentRestaurant?.foods.desserts)!{
            for i in foodsList{
                if item.name == i{
                    caloriesList.append(item.calories!)
                }
            }
        }
        return caloriesList
    }
    
    func getTotalCalories() -> Int{
        var sum = 0
        for (key,value) in foodsDictionary{
            let list = getCalories(foodsList: value as! Array<String>, restaurant: key)
            for element in list{
                let a: Int = Int(element)!
                sum += a
            }
        }
        return sum
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
