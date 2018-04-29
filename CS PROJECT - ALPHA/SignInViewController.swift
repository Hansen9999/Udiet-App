//
//  SignInViewController.swift
//  CS PROJECT - ALPHA
//
//  Created by Hansen Pen on 3/30/18.
//  Copyright © 2018 Hansen Pen. All rights reserved.
//

import UIKit
import FBSDKLoginKit



class SignInViewController: UIViewController,UITextFieldDelegate,FBSDKLoginButtonDelegate {
    
    var alertController: UIAlertController? = nil
    
    var loginsuccess = false
    
    let urlCondition = NSCondition()
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var passwordImage: UIImageView!
    
    
    
    
    
    @IBAction func forgetButton(_ sender: Any) {
        self.alertController = UIAlertController(title: "Forgot User ID or Password", message: "Please registrar a new account, this function is currently under development \(Emoji.sadFace)", preferredStyle: UIAlertControllerStyle.alert)
        
        let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action:UIAlertAction) in
        }
        self.alertController!.addAction(OKAction)
        
        self.present(self.alertController!, animated: true, completion:nil)
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
        
        if let userToken = result.token
        {
            let token:FBSDKAccessToken = result.token
            print("Token = \(FBSDKAccessToken.current().tokenString)")
            
            print("User ID = \(FBSDKAccessToken.current().userID)")
            
            let myTabBar = self.storyboard?.instantiateViewController(withIdentifier: "myTabBar") as! UITabBarController
            let appDelegate = UIApplication.shared.delegate
            appDelegate?.window??.rootViewController = myTabBar
            
            
    }
    }
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
        print("User is logged out")
    }
    

    @IBOutlet weak var LoginButton: FBSDKLoginButton!
    
    @IBOutlet weak var SignInBtn: UIButton!
    
    @IBOutlet weak var PasswordTextField: UITextField!
    
    @IBOutlet weak var UserNameTextField: UITextField!
    
    
    

    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        UserNameTextField.resignFirstResponder()
        PasswordTextField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LoginButton.layer.cornerRadius = Config.defaultCornerRadius
       
        passwordImage.image = UIImage(named: "password")
        userImage.image = UIImage(named: "user")
        navigationItem.hidesBackButton = true
        navigationController?.isNavigationBarHidden = true
    
        self.UserNameTextField.delegate = self
        self.PasswordTextField.delegate = self
        
        UserNameTextField.layer.borderWidth = 1
        UserNameTextField.layer.borderColor = UIColor.white.cgColor
        UserNameTextField.layer.cornerRadius = 15
        UserNameTextField.clipsToBounds = true
        
        PasswordTextField.layer.borderWidth = 1
        PasswordTextField.layer.borderColor = UIColor.white.cgColor
        PasswordTextField.layer.cornerRadius = 15
        PasswordTextField.clipsToBounds = true
        
        SignInBtn.layer.cornerRadius = 15
        SignInBtn.layer.borderColor = UIColor.white.cgColor
        SignInBtn.layer.borderWidth = 1.0
        SignInBtn.clipsToBounds = true
        
  
        
        LoginButton.delegate = self
        LoginButton.readPermissions = ["public_profile","email","user_friends"]
        
        
        PasswordTextField.isSecureTextEntry = true

        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background")
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        // Do any additional setup after loading the view.
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "login"{
            let destinationVC = segue.destination as! TabBarController

            destinationVC.Username = UserNameTextField.text!

            destinationVC.Password = PasswordTextField.text!
            
            print("nonon")
            
        }
    }

    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {

        if let ident = identifier {
            if ident == "login" {
                if loginsuccess != true {
                    print("1")
                    return false
                }
            }
        }
        print("4")

        
        return true
        
    }

        
        
        

    @IBAction func RegisterButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let  registerController = storyboard.instantiateViewController(withIdentifier: "Register") as? RegisterViewController
            // Set the delegate - which would be me (that is, I conform to the protocol)

            // Present the view controller over the current one.
        self.present(registerController!, animated: true, completion: nil)



    }
    
    

    
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func SignInButton(_ sender: Any) {
        if (UserNameTextField.text?.isEmpty)! || (PasswordTextField.text?.isEmpty)! {
            // Display Alert message
            displayMessage(userMessage: "All fields are required to fill in.")
            
            return
        }
        else{
            self.loginsuccess = false
            
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
            
            
            let postString = ["username": UserNameTextField.text!,
                              "password": PasswordTextField.text!,
                              ] as [String: String]
            
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
                            self.loginsuccess = false
                            
                            print("login fail, time to wake up main")
                            self.urlCondition.signal()
                            self.urlCondition.unlock()
                            
                            return
                        }
                        
                        print("2")
                        self.loginsuccess = true
                        print("3")
                        
                        print("login success, time to wake up main")
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
