//
//  CommentsViewController.swift
//  CS PROJECT - ALPHA
//
//  Created by Hansen Pen on 4/11/18.
//  Copyright © 2018 Hansen Pen. All rights reserved.
//

import UIKit

class CommentsViewController: UIViewController,UITextViewDelegate {
    let urlCondition = NSCondition()
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    @IBAction func postbtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    var alertController: UIAlertController? = nil
    
    var reviewList = [String]()
    
    struct ResponseDescriptor: Decodable {
        let message: String
        let status: Int
        let reviews: [Review]
    }
    
    struct Review: Decodable {
        let id: Int
        let content: String
    }
    
    
    
    
    
    
    
    
    
    
    var restaurant: Restaurant?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = restaurant?.name
        
        
        self.textView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.textView.resignFirstResponder()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.backgroundColor = UIColor.lightGray
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.backgroundColor = UIColor.white
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        countLabel.text = "\(textView.text.characters.count)"
        return textView.text.characters.count + (text.characters.count - range.length) <= 140
        
    }

    
    @IBAction func PostComments(_ sender: UIButton) {
        var addComments = String(textView.text)
        
        
        let myActivityIndicator =  UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        myActivityIndicator.center = view.center
        
        myActivityIndicator.hidesWhenStopped = false
        myActivityIndicator.stopAnimating()
        
        view.addSubview(myActivityIndicator)
        
        
        let myUrl = URL(string: "http://54.244.61.231:8080/restaurant/review/create")
        var request = URLRequest(url:myUrl!)
        request.httpMethod = "POST"// Compose a query string
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        
        let postString = ["restaurant_name": restaurant?.name,
                          "content": addComments,
                          ] as! [String: String]
        
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
                
                if let parseJSON = json {
                    
                    
                    let status = parseJSON["status"] as? Int
                    
                    
                    if status != 0
                    {
                        
                        self.displayMessage(userMessage: "Could not successfully perform this request. Please try again later")
                        return
                    }
                    
                    
                    // Display an Alert dialog with a friendly error message
                    DispatchQueue.global().async {

                        
                        self.urlCondition.signal()
                        self.urlCondition.unlock()
                        
                    }
                    
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
        
        
        self.urlCondition.lock()
        task.resume()
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
                let responseDescriptor = try JSONDecoder().decode(CommentsViewController.ResponseDescriptor.self, from: data)
                
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
    
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        getReviewList()
        if segue.identifier == "post"{
            if let destinationVC = segue.destination as? ReviewPageViewController{
                destinationVC.reviewList = reviewList
            }
        }
    }
     */

    
        
        
        
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
