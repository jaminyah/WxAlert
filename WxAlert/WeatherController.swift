//
//  WeatherController.swift
//  WxAlert
//
//  Created by macbook on 3/20/18.
//  Copyright © 2018 Jaminya. All rights reserved.
//

import UIKit

class WeatherController: UIViewController, UICollectionViewDataSource, GestureProtocol {
    
    @IBOutlet weak var alertCollection: UICollectionView!
    @IBOutlet weak var wxCollection:  UICollectionView!
    @IBOutlet weak var cityLabel: UILabel!

    let rootController = RootController.sharedInstance
    let dbmgr = DbMgr.sharedInstance
    var delegate: CityProtocol? = nil
    
    lazy var alertCollectionController = AlertCollectionController()
    var viewModel: WxCellVM? = nil
    //lazy var wxCollectionController = WxCollectionController()

    var selectedCity: SelectedCity!
    
    var alertModels: [AlertModel] = []
    var pages = Pages()
    
    override func viewDidLoad() {
        print("Weather Controller")
        
        super.viewDidLoad()
        self.delegate = rootController
        
        // Set data source and delegate
        alertCollection.dataSource = alertCollectionController
        alertCollection.delegate = alertCollectionController
        
        wxCollection.dataSource = self
        //wxCollection.delegate = wxCollectionController
        
        // hide views
        alertCollection.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        navigationController?.navigationBar.isHidden = true
        selectedCity = self.delegate?.getSelectedCity()
        cityLabel.text = selectedCity.name + ", " + selectedCity.state
        viewModel = WxCellVM()
    }
    
    override func viewDidAppear(_ animated: Bool) {

        tabBarController?.tabBar.isHidden = false
        let alertViewModel = AlertViewModel()
        alertModels.removeAll()
        alertModels = alertViewModel.fetchAlerts()
        alertCollectionController.alertModels = alertModels
        alertCollection.reloadData()
        wxCollection.reloadData()
        
        // Example inDate: 2019-03-22T23:43:09-06:00
        let rfc3339Formater = DateFormatter()
        rfc3339Formater.locale = Locale(identifier: "en_US_POSIX")
        rfc3339Formater.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        rfc3339Formater.timeZone = TimeZone.init(secondsFromGMT: 0)
        
        let systemClock = Date()
        let systemClockString = rfc3339Formater.string(from: systemClock)
        let rfc3339systemClock = rfc3339Formater.date(from: systemClockString)
        print("systemClockString: \(rfc3339systemClock!)")
        
        /*
         - Get system time
         - Get expiration time of first weather day element
         - if system time < weather expiration time
            - wxCollection.reloadData()
         - else if system time > weather expiration time
            - start activity indicator
            - fetch updated wx data using wxOperations class
            - clear db and write current data
            - wxCollection.reloadData()
            - end activity indicator
         - else
            - On a background thread
            - Start a countdown timer to expiration time + 30 minutes
            - On expiration
                - start activity indicator
                - fetch updated wx data using wxOperations class
                - clear db and write current data
                - wxCollection.reloadData()
                - end activity indicator
        */
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: wxCollection UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.cellModels.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WxCell", for: indexPath) as? WxViewCell
        
        cell?.delegate = self                                        // delegate must conform to GestureProtocol
        cell?.backgroundColor = generateRandomPastelColor(withMixedColor: .cyan)
        cell?.displayWeather(forecast: viewModel!.cellModels[indexPath.row], models: alertModels)
        return cell!
    }
    
    // https://gist.github.com/JohnCoates/725d6d3c5a07c4756dec
    func generateRandomPastelColor(withMixedColor mixColor: UIColor?) -> UIColor {
        // Randomly generate number in closure
        let randomColorGenerator = { ()-> CGFloat in
            CGFloat(arc4random() % 256 ) / 256
        }
        
        var red: CGFloat = randomColorGenerator()
        var green: CGFloat = randomColorGenerator()
        var blue: CGFloat = randomColorGenerator()
        
        // Mix the color
        if let mixColor = mixColor {
            var mixRed: CGFloat = 0, mixGreen: CGFloat = 0, mixBlue: CGFloat = 0;
            mixColor.getRed(&mixRed, green: &mixGreen, blue: &mixBlue, alpha: nil)
            
            red = (red + mixRed) / 2;
            green = (green + mixGreen) / 2;
            blue = (blue + mixBlue) / 2;
        }
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    
    
    func monitorWxTimestamp() {
        print("monitorWxTimestamp")
        // get db timestamp
       // if current datetime > timestamp {
       //    send out notification to registered listeners
        //  } else {
        // operate a countdown timer
        // send out notification when timer expires
    }
    
    func performAlertViewSegue() {
        print("performAlertViewSegue")
        
        pages.array.removeAll()
        for model in alertModels {
            guard let viewController = AlertDetailViewModel(alertModel: model).createViewController() else { return }
            pages.array.append(viewController)
        }
        tabBarController?.tabBar.isHidden = true
        performSegue(withIdentifier: "AlertDetailSegue", sender: self)
    }
    

    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        navigationController?.navigationBar.isHidden = false
        if let destinationVC = segue.destination as? PageViewController {
            destinationVC.pages.array = pages.array
        }
    }
} // class
