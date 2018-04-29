//
//  SetBackgroundViewController.swift
//  
//
//  Created by Anqi Lou on 2018/4/15.
//

import UIKit

class SetBackgroundViewController: UIViewController {
  
    
    
    let urlCondition = NSCondition()
    
    
    var uploadBackgroundname = false

    
    struct ResponseDescriptor: Decodable {
        let message: String
        let status: Int
        let info: info
    }
    
    struct info: Decodable {
        let calories:[calories]
        let name: String
        let today_foods: [today_foods]
        let background: String
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
    
    
    var Username: String = ""
    var Password: String = ""

    var backgroundName: String?
    
    @IBOutlet weak var No1: UIButton!
    @IBOutlet weak var No2: UIButton!
    @IBOutlet weak var No3: UIButton!
    @IBOutlet weak var No4: UIButton!
    @IBOutlet weak var No5: UIButton!
    @IBOutlet weak var No6: UIButton!
    
    var alertController: UIAlertController? = nil
    
    @IBAction func No1Selected(_ sender: Any) {
        backgroundName = "profileBackground1"
        reset()
        No1.layer.borderColor = UIColor.blue.cgColor
        No1.layer.borderWidth = 3.5
    }
    
    @IBAction func No2Selected(_ sender: Any) {
        backgroundName = "profileBackground2"
        reset()
        No2.layer.borderColor = UIColor.blue.cgColor
        No2.layer.borderWidth = 3.5
    }
    
    @IBAction func No3Selected(_ sender: Any) {
        backgroundName = "profileBackground3"
        reset()
        No3.layer.borderColor = UIColor.blue.cgColor
        No3.layer.borderWidth = 3.5
    }
    
    @IBAction func No4Selected(_ sender: Any) {
        backgroundName = "profileBackground4"
        reset()
        No4.layer.borderColor = UIColor.blue.cgColor
        No4.layer.borderWidth = 3.5
    }
    
    @IBAction func No5Selected(_ sender: Any) {
        backgroundName = "profileBackground5"
        reset()
        No5.layer.borderColor = UIColor.blue.cgColor
        No5.layer.borderWidth = 3.5
    }
    
    @IBAction func No6Selected(_ sender: Any) {
        backgroundName = "profileBackground6"
        reset()
        No6.layer.borderColor = UIColor.blue.cgColor
        No6.layer.borderWidth = 3.5
    }
    
    func reset(){
        No1.layer.borderWidth = 0
        No2.layer.borderWidth = 0
        No3.layer.borderWidth = 0
        No4.layer.borderWidth = 0
        No5.layer.borderWidth = 0
        No6.layer.borderWidth = 0
    }
    
    @IBAction func changeBackground(_ sender: Any) {
        uploadBackground()
        self.alertController = UIAlertController(title: "Saved", message: "Profile Background Changed", preferredStyle: UIAlertControllerStyle.alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: { _ -> Void in
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "myTabBar") as! TabBarController
            nextViewController.backgroundName = self.backgroundName!
            nextViewController.Username = self.Username
            nextViewController.Password = self.Password

            print("55555")
            self.present(nextViewController, animated: true, completion: nil)
            print("lakjsdfl;a")
        })
        
        self.alertController!.addAction(OKAction)
        
        self.present(self.alertController!, animated: true, completion:nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = false
        navigationController?.isNavigationBarHidden = false
        print(Username)
        print(Password)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func uploadBackground(){
        let myActivityIndicator =  UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        myActivityIndicator.center = view.center
        
        myActivityIndicator.hidesWhenStopped = false
        myActivityIndicator.stopAnimating()
        
        view.addSubview(myActivityIndicator)
        
        
        let myUrl = URL(string: "http://54.244.61.231:8080/user/background")
        var request = URLRequest(url:myUrl!)
        request.httpMethod = "POST"// Compose a query string
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        
        let postString = ["username": Username,
                          "password": Password,
                          "background": backgroundName,
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
                        self.uploadBackgroundname = true
                    
                        print("login fail, time to wake up main")
                        self.urlCondition.signal()
                        self.urlCondition.unlock()
                        
                        return
                    }
                    
                    print("2")
                    self.uploadBackgroundname = true
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
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
