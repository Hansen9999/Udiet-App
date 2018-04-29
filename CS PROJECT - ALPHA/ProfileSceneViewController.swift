//
//  ProfileSceneViewController.swift
//  CS PROJECT - ALPHA
//
//  Created by Hansen Pen on 3/31/18.
//  Copyright © 2018 Hansen Pen. All rights reserved.
//

import UIKit
import Charts
class ProfileSceneViewController: UIViewController{
    var caloriesList : [Int] = []
    
    
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
        let date: String
    }
    
    
    
    let urlCondition = NSCondition()
    
    var Username: String = ""
    var Password: String = ""


    var profileBackground = ""
    @IBOutlet weak var dataSent: UILabel!
    
    
    @IBAction func ThreeMonthChart(_ sender: UIButton) {
        var lineChartEntry = [ChartDataEntry]()
        var QuarterAverage = [Int]()
        var sumQuarter: Int
        
        
        if caloriesList.count >= 90{
            for i in (caloriesList.count - 90)...(caloriesList.count - 1){
                let value = ChartDataEntry(x: Double(i + 1), y: Double(caloriesList[i]))
                lineChartEntry.append(value)
                QuarterAverage.append(caloriesList[i])
                sumQuarter = QuarterAverage.reduce(0, +)
                averageCal.text = String(sumQuarter/90)
                
            }
        }else{
            if caloriesList.count != 0{
                for i in 0...(caloriesList.count - 1){
                    let value = ChartDataEntry(x: Double(i + 1), y: Double(caloriesList[i]))
                    lineChartEntry.append(value)
                    QuarterAverage.append(caloriesList[i])
                    sumQuarter = QuarterAverage.reduce(0, +)
                    let days = caloriesList.count
                    averageCal.text = String(sumQuarter/days)
                }
            }
            
            
        }
        
        let line1 = LineChartDataSet(values: lineChartEntry, label: "Calories")
        line1.colors = [NSUIColor.orange]
        let data = LineChartData()
        data.addDataSet(line1)
        LineChartView.data = data
        LineChartView.chartDescription?.text = "Quarterly"
        LineChartView.rightAxis.enabled = false
        LineChartView.xAxis.labelPosition = .bottom
        LineChartView.xAxis.drawGridLinesEnabled = false
        LineChartView.leftAxis.drawGridLinesEnabled = false
        LineChartView.animate(xAxisDuration: 2, yAxisDuration: 2)
        let gradientColors = [ChartColorTemplates.colorFromString("#00ff0000").cgColor,
                              ChartColorTemplates.colorFromString("#ffff0000").cgColor]
        let gradient = CGGradient(colorsSpace: nil, colors: gradientColors as CFArray, locations: nil)!
        line1.fillAlpha = 1
        line1.fill = Fill(linearGradient: gradient, angle: 90)
       
        line1.circleHoleColor = UIColor.orange
        line1.drawFilledEnabled = true
        line1.fillAlpha = 65/255
        line1.fillColor = UIColor.orange.withAlphaComponent(200/255)
        data.setDrawValues(false)
        line1.circleRadius = 1.0
    }
    @IBAction func WeekChart(_ sender: UIButton) {
        var lineChartEntry = [ChartDataEntry]()
        var WeekAverage: [Int] = []
        var sumWeek: Int
        
        
        if caloriesList.count >= 7{
            for i in (caloriesList.count - 7)...(caloriesList.count - 1){
                let value = ChartDataEntry(x: Double(i + 1), y: Double(caloriesList[i]))
                lineChartEntry.append(value)
                WeekAverage.append(caloriesList[i])
                sumWeek = WeekAverage.reduce(0, +)
                averageCal.text = String(sumWeek/7)
            }
        }else{
            if caloriesList.count != 0{
                for i in 0...(caloriesList.count - 1){
                    let value = ChartDataEntry(x: Double(i + 1), y: Double(caloriesList[i]))
                    lineChartEntry.append(value)
                    WeekAverage.append(caloriesList[i])
                    sumWeek = WeekAverage.reduce(0, +)
                    let days = caloriesList.count
                    averageCal.text = String(sumWeek/days)
                    
                }
            }
            
            
        }
        
        let line1 = LineChartDataSet(values: lineChartEntry, label: "Calories")
        line1.colors = [NSUIColor.orange]
        let data = LineChartData()
        data.addDataSet(line1)
        LineChartView.data = data
        LineChartView.chartDescription?.text = "Weekly"
        LineChartView.rightAxis.enabled = false
        LineChartView.xAxis.labelPosition = .bottom
        LineChartView.xAxis.drawGridLinesEnabled = false
        LineChartView.leftAxis.drawGridLinesEnabled = false
        LineChartView.animate(xAxisDuration: 2, yAxisDuration: 2)
        let gradientColors = [ChartColorTemplates.colorFromString("#00ff0000").cgColor,
                              ChartColorTemplates.colorFromString("#ffff0000").cgColor]
        let gradient = CGGradient(colorsSpace: nil, colors: gradientColors as CFArray, locations: nil)!
        line1.fillAlpha = 1
        line1.fill = Fill(linearGradient: gradient, angle: 90)
        line1.drawFilledEnabled = true
        line1.fillAlpha = 65/255
        line1.fillColor = UIColor.orange.withAlphaComponent(200/255)
        line1.circleHoleColor = UIColor.orange
        
        line1.circleRadius = 2.0
        
        
        
    }
    @IBAction func MonthChart(_ sender: UIButton) {
        var lineChartEntry = [ChartDataEntry]()
        var MonthlyAverage = [Int]()
        var sumMonth: Int
        
        if caloriesList.count >= 30{
            for i in (caloriesList.count - 30)...(caloriesList.count - 1){
                let value = ChartDataEntry(x: Double(i + 1), y: Double(caloriesList[i]))
                lineChartEntry.append(value)
                MonthlyAverage.append(caloriesList[i])
                sumMonth = MonthlyAverage.reduce(0, +)
                averageCal.text = String(sumMonth/30)
            }
        }else{
            if caloriesList.count != 0 {
                for i in 0...(caloriesList.count - 1){
                    let value = ChartDataEntry(x: Double(i + 1), y: Double(caloriesList[i]))
                    lineChartEntry.append(value)
                    MonthlyAverage.append(caloriesList[i])
                    sumMonth = MonthlyAverage.reduce(0, +)
                    let days = caloriesList.count
                    averageCal.text = String(sumMonth / days)
                }

            }
            
        }
        
        let line1 = LineChartDataSet(values: lineChartEntry, label: "Calories")
        line1.colors = [NSUIColor.orange]
        let data = LineChartData()
        data.addDataSet(line1)
        LineChartView.data = data
        LineChartView.chartDescription?.text = "Monthly"
        
        LineChartView.rightAxis.enabled = false
        LineChartView.xAxis.labelPosition = .bottom
        LineChartView.xAxis.drawGridLinesEnabled = false
        LineChartView.leftAxis.drawGridLinesEnabled = false
        LineChartView.animate(xAxisDuration: 2, yAxisDuration: 2)
        
       
        data.setDrawValues(false)
        
        
        let gradientColors = [ChartColorTemplates.colorFromString("#00ff0000").cgColor,
                              ChartColorTemplates.colorFromString("#ffff0000").cgColor]
        let gradient = CGGradient(colorsSpace: nil, colors: gradientColors as CFArray, locations: nil)!
        line1.fillAlpha = 1
        line1.fill = Fill(linearGradient: gradient, angle: 90)
        line1.drawFilledEnabled = true
        line1.fillAlpha = 65/255
        line1.fillColor = UIColor.orange.withAlphaComponent(200/255)
        line1.circleRadius = 1.0
        line1.circleHoleColor = UIColor.orange
        
        
    }
    func setUpChart(){
        var lineChartEntry = [ChartDataEntry]()
        var WeekAverage: [Int] = []
        var sumWeek: Int
        
        
        if caloriesList.count >= 7{
            for i in (caloriesList.count - 7)...(caloriesList.count - 1){
                let value = ChartDataEntry(x: Double(i + 1), y: Double(caloriesList[i]))
                lineChartEntry.append(value)
                WeekAverage.append(caloriesList[i])
                sumWeek = WeekAverage.reduce(0, +)
                averageCal.text = String(sumWeek/7)
            }
        }else{
            if caloriesList.count != 0{
                for i in 0...(caloriesList.count - 1){
                    let value = ChartDataEntry(x: Double(i + 1), y: Double(caloriesList[i]))
                    lineChartEntry.append(value)
                    WeekAverage.append(caloriesList[i])
                    sumWeek = WeekAverage.reduce(0, +)
                    let days = caloriesList.count
                    averageCal.text = String(sumWeek/days)
                    
                }
            }
            
            
        }
        let line1 = LineChartDataSet(values: lineChartEntry, label: "Calories")
        line1.colors = [NSUIColor.orange]
        let data = LineChartData()
        data.addDataSet(line1)
        LineChartView.data = data
        LineChartView.chartDescription?.text = "Weekly"
        LineChartView.rightAxis.enabled = false
        LineChartView.xAxis.labelPosition = .bottom
        LineChartView.xAxis.drawGridLinesEnabled = false
        LineChartView.leftAxis.drawGridLinesEnabled = false
        LineChartView.animate(xAxisDuration: 2, yAxisDuration: 2)
        
        
        let gradientColors = [ChartColorTemplates.colorFromString("#00ff0000").cgColor,
                              ChartColorTemplates.colorFromString("#ffff0000").cgColor]
        let gradient = CGGradient(colorsSpace: nil, colors: gradientColors as CFArray, locations: nil)!
        line1.fillAlpha = 1
        line1.fill = Fill(linearGradient: gradient, angle: 90)
        line1.fillAlpha = 65/255
        line1.circleHoleColor = UIColor.orange
        line1.fillColor = UIColor.orange.withAlphaComponent(200/255)
        line1.drawFilledEnabled = true
        
        line1.circleRadius = 2.0
    
    }
    /*
    func backgroundSwitch(){
        if profileBackground == ""{
            profileBackground = "ProfileBackground"
        }
        let backgroundImage = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 270))
        backgroundImage.image = UIImage(named: profileBackground)
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
 */

    
    @IBOutlet weak var LineChartView: LineChartView!
    @IBOutlet weak var SignOut: UIButton!
    @IBAction func SignoutBtn(_ sender: Any) {
    }
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var averageCal: UILabel!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("at view did appear1")
        
        getData()
        setupBackground()
        setUpChart()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("at view did load 1")
        /*
        
        */
        navigationController?.isNavigationBarHidden = false
        navigationItem.hidesBackButton = true
        tabBarController?.tabBar.isHidden = false
        
        self.title = "Profile"

        print("Background")

        

        

        
        userImage.layer.cornerRadius = userImage.frame.size.width / 2
        userImage.clipsToBounds = true
        userImage.image = UIImage(named: "User1")
        userImage.layer.borderWidth = 3
        userImage.layer.borderColor = UIColor.white.cgColor
        SignOut.layer.cornerRadius = Config.defaultCornerRadius
        
        
        
        
        getData()
        
        setupBackground()
        
        
        setUpChart()
        
        print(profileBackground)
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupBackground(){
        let backgroundImage = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 270))
        backgroundImage.image = UIImage(named: profileBackground)
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
    }
    
    func getData(){
        print("111")
        
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
            print("12")
            
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
                print("13")
                guard let data = data else {
                    print("error - error getting data")
                    return
                }
                print("14")
                print(self.Username)
                print(self.Password)
                let responseDescriptor = try JSONDecoder().decode(ProfileSceneViewController.ResponseDescriptor.self, from: data)
                
                print("15")
                
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
                   
                    
                    
                    self.profileBackground = (info?.background)!
                    
                    print(self.profileBackground)
                    if y?.count != 0{
                        let calories = info?.calories as? [calories]
                        
                        let onemealcalories = calories![0].calorie
                        
                        //                    clear old data
                        self.caloriesList = []
                        for elements in calories!{
                            self.caloriesList.append(Int(elements.calorie))
                            
                        }
                        print (self.caloriesList)
                        
                        
                        print("complete: after get review list")
                        
                    }
                    
                    
                    
                    
                    
                    
                    // case 1: empty reviewList
                    // case 2: has content -> then for loop, store contents in a single list called reviews
                    
    
                    
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
        if segue.identifier == "settings"{
  
                if let destinationVC = segue.destination as? SettingsTableViewController{
                    destinationVC.Username = Username
                    destinationVC.Password = Password
                
            }
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
