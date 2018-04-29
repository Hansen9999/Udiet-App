//
//  RecordFoodViewController.swift
//  CS PROJECT - ALPHA
//
//  Created by Anqi Lou on 2018/4/9.
//  Copyright © 2018年 Hansen Pen. All rights reserved.
//

import UIKit

class RecordFoodViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    var Username: String = ""
    var Password: String = ""
    let urlCondition = NSCondition()
    var restaurant: Restaurant?
    var foods: Food?
    var foodList: [Item] = [Item]()
    var alertController: UIAlertController? = nil
    var sortedList: [Item] = [Item]()
    
    var finallist = [String]()
    var Mealcalories: Int = 0
    var tableTag : Int = 0
    
    var switchStatus1: [Int] = [Int]()
    var switchStatus2: [Int] = [Int]()
    var switchStatus3: [Int] = [Int]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var restaurantName: UILabel!
    
    var uploadSuccess = false
    
    @IBAction func Xsegment(_ sender: UISegmentedControl) {
        
        
        if sender.selectedSegmentIndex == 0{
            tableTag = 0
            print("12313123")
            
            tableView.reloadData()
            
        }
        if sender.selectedSegmentIndex == 1{
            tableTag = 1
            print("1231230123-1")
            tableView.reloadData()
            
        }
        if sender.selectedSegmentIndex == 2{
            tableTag = 2
            print("133333333")
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableTag == 0{
            return (foods?.entree.count)!
        }else{
            if tableTag == 1{
                return (foods?.sides.count)!
            }else{
                if tableTag == 2{
                    return (foods?.desserts.count)!
                }else{
                    return 0
                }
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /*
        if tableView == entree{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath)
            let entree = foods?.entree[indexPath.row]
            cell.textLabel?.text = entree?.name
            return cell
        */
        if tableTag == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "chosenCell", for: indexPath)
            let entree = foods?.entree[indexPath.row]
            cell.textLabel?.text = entree?.name
            let switchView = UISwitch(frame: .zero)
            if switchStatus1[indexPath.row] == 0{
                switchView.setOn(false, animated: true)
            }else{
                switchView.setOn(true, animated: false)
            }
            switchView.tag = indexPath.row
            switchView.addTarget(self, action: #selector(self.switchChanged1(_:)), for: .valueChanged)
            cell.accessoryView = switchView
            return cell
        
        }else{
            if tableTag == 1{
                let cell = tableView.dequeueReusableCell(withIdentifier: "chosenCell", for: indexPath)
                let side = foods?.sides[indexPath.row]
                cell.textLabel?.text = side?.name
                let switchView = UISwitch(frame: .zero)
                if switchStatus2[indexPath.row] == 0{
                    switchView.setOn(false, animated: true)
                }else{
                    switchView.setOn(true, animated: false)
                }
                switchView.tag = indexPath.row
                switchView.addTarget(self, action: #selector(self.switchChanged2(_:)), for: .valueChanged)
                cell.accessoryView = switchView
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "chosenCell", for: indexPath)
                let des = foods?.desserts[indexPath.row]
                cell.textLabel?.text = des?.name
                let switchView = UISwitch(frame: .zero)
                if switchStatus3[indexPath.row] == 0{
                    switchView.setOn(false, animated: true)
                }else{
                    switchView.setOn(true, animated: false)
                }
                switchView.tag = indexPath.row
                switchView.addTarget(self, action: #selector(self.switchChanged3(_:)), for: .valueChanged)
                cell.accessoryView = switchView
                return cell
                
            }
        }
 
    }
    
    func record() {
        print("record")
        print(Thread.current)
        if foodList.count > 0{
            
            var allfoods = ""
            for items in (foods?.entree)!{
                for elements in foodList{
                    if elements.name == items.name{
                        sortedList.append(elements)
                        Mealcalories += Int(elements.calories!)!
                    }
                }
            }
            for items in (foods?.sides)!{
                for elements in foodList{
                    if elements.name == items.name{
                        sortedList.append(elements)
                        Mealcalories += Int(elements.calories!)!
                    }
                }
            }
            for items in (foods?.desserts)!{
                for elements in foodList{
                    if elements.name == items.name{
                        sortedList.append(elements)
                        Mealcalories += Int(elements.calories!)!
                    }
                }
            }
            for elements in sortedList{
                var name = elements.name
                finallist.append(name!)
                print(finallist)
                
            }
        }else{
            self.alertController = UIAlertController(title: "Alert", message: "You have not selected anything", preferredStyle: UIAlertControllerStyle.alert)
            
            let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action:UIAlertAction) in
                print("Ok Button Pressed 1");
            }
            self.alertController!.addAction(OKAction)
            
            self.present(self.alertController!, animated: true, completion:nil)
            
        }
    

            
            let myActivityIndicator =  UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
            myActivityIndicator.center = view.center
            
            myActivityIndicator.hidesWhenStopped = false
            myActivityIndicator.stopAnimating()
            
            view.addSubview(myActivityIndicator)
            
            
            let myUrl = URL(string: "http://54.244.61.231:8080/user/food")
            var request = URLRequest(url:myUrl!)
            request.httpMethod = "POST"// Compose a query string
            request.addValue("application/json", forHTTPHeaderField: "content-type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            
            let postString = ["username": Username,
                              "password": Password,
                              "restaurant": restaurant?.name as! String,
                              "foods": self.finallist,
                              "calorie": Mealcalories
                ] as [String: Any]
            print (postString)
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: postString, options: .prettyPrinted)
            } catch let error {
                print(error.localizedDescription)
                displayMessage(userMessage: "Something went wrong. Try again.")
                return
            }
            
            let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
                
                self.removeActivityIndicator(activityIndicator: myActivityIndicator)
                
                if error != nil
                {
                    self.displayMessage(userMessage: "response data nil")
                    print("error=\(String(describing: error))")
                    return
                }
                
                
                //Let's convert response sent from a server side code to a NSDictionary object:
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                    
                    print("network get data")
                    if let parseJSON = json {
                        
                        
                        let status = parseJSON["status"] as? Int
                        
                        
                        if status != 0
                        {
                            
                            self.displayMessage(userMessage: "Could not successfully perform this request. Please try again later")
                            
                            self.uploadSuccess = false
                            print("login fail, time to wake up main")
                            self.urlCondition.signal()
                            self.urlCondition.unlock()
                            
                            return
                        }
                        
                        print("2")
                        self.uploadSuccess = true
                        print("3")
                        
                        print("upload success, time to wake up main")
                        self.urlCondition.signal()
                        self.urlCondition.unlock()
                        
                        // Display an Alert dialog with a friendly error message
                        /*
                         DispatchQueue.main.async {
                         print("2")
                         self.loginsuccess = true
                         print("3")
                         
                         print("login success, time to wake up main")
                         self.urlCondition.signal()
                         self.urlCondition.unlock()
                         }
                         */
                        
                    } else {
                        //Display an Alert dialog with a friendly error message
                        self.displayMessage(userMessage: "Could not successfully perform this request. Please try again later")
                    }
                } catch {
                    
                    self.removeActivityIndicator(activityIndicator: myActivityIndicator)
                    
                    // Display an Alert dialog with a friendly error message
                    self.displayMessage(userMessage: "Could not successfully perform this request. Please try again later")
                    print(error)
                }
            }
            
            print("initial lock")
            self.urlCondition.lock()
            task.resume()
            print("begin waiting")
            self.urlCondition.wait()
            print("main wake up")
            self.urlCondition.unlock()
            
        
            /*
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "record") as! RecordViewController
            nextViewController.dataReceived.text = allfoods
            self.present(nextViewController, animated: true, completion: nil)
            */
                
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
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "uploadback"{
            let destinationVC = segue.destination as! RecordViewController
            
            destinationVC.SortedList = SortedList
     
            
            print("nonon")
            
        }
    }
    */
    
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        
        
        /// record_123
        
        
        // sleep
        
        //wake up
        
        if let ident = identifier {
            if ident == "uploadback" {
                record()
                print(Thread.current)
                print("1.1")
                if self.uploadSuccess != true {
                    print("1")
                    return false
                }else{
                        return true
                    }
                }
            
            if ident == "foodback"{
                return true
            }
        }
        
        
        print("31231")
        return true
        
    }
    
    /*
    func memorizeSwitch1()->[Int]{
        return switchStatus1
    }
    
    func memorizeSwitch2()->[Int]{
        return switchStatus2
    }
    
    func memorizeSwitch3()->[Int]{
        return switchStatus3
    }
    */
   
    @objc func switchChanged1(_ sender : UISwitch!){
        if sender.isOn{
            foodList.append(foods!.entree[sender.tag])
            switchStatus1[sender.tag] = 1
        }else{
            foodList = foodList.filter({$0.name != foods!.entree[sender.tag].name!})
            switchStatus1[sender.tag] = 0
        }
    }
    
    @objc func switchChanged2(_ sender : UISwitch!){
        if sender.isOn{
            foodList.append(foods!.sides[sender.tag])
            switchStatus2[sender.tag] = 1
        }else{
            foodList = foodList.filter({$0.name != foods!.sides[sender.tag].name!})
            switchStatus2[sender.tag] = 0
        }
        
    }
    @objc func switchChanged3(_ sender : UISwitch!){
        if sender.isOn{
            foodList.append(foods!.desserts[sender.tag])
            switchStatus3[sender.tag] = 1
        }else{
            foodList = foodList.filter({$0.name != foods!.desserts[sender.tag].name!})
            switchStatus3[sender.tag] = 0
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
  
        self.restaurantName.text = restaurant?.name
        navigationItem.hidesBackButton = true
        navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.isHidden = true
        
        for i in (foods?.entree)!{
            switchStatus1.append(0)
        }
        
        for j in (foods?.sides)!{
            switchStatus2.append(0)
        }
        
        for k in (foods?.desserts)!{
            switchStatus3.append(0)
        }
        
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
        print("2")
            if segue.identifier == "foodback"{
                if let destinationVC = segue.destination as? RecordViewController{
                    destinationVC.Username = Username
                    destinationVC.Password = Password
                }
        }
            if segue.identifier == "uploadback"{
                if let destinationVC1 = segue.destination as? RecordViewController{
                    destinationVC1.Username = Username
                    destinationVC1.Password = Password
                }
                
                
                
            
              }

    



}
}
