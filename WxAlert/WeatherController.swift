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
    @IBOutlet weak var cityCollection: UICollectionView!
    @IBOutlet weak var wxCollection:  UICollectionView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var date: UILabel!
    
    
    let rootController = RootController.sharedInstance
    let dbmgr = DbMgr.sharedInstance
    var delegate: CityProtocol? = nil
    
    lazy var alertCollectionController = AlertCollectionController()
    lazy var wxCollectionController = WxCollectionController()
    //let cityCollectionController = CityCollectionController()

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
        wxCollection.delegate = wxCollectionController
        
        // hide views
        alertCollection.isHidden = false
        //navigationController?.navigationBar.isHidden = true
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        selectedCity = self.delegate?.getSelectedCity()
        cityLabel.text = selectedCity.name + ", " + selectedCity.state
       // wxCollectionController.viewModel = WxCellVM()
        wxCollection.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        let alertViewModel = AlertViewModel()   /** VARIABLE DECLARATION ISSUE **/
        alertModels = alertViewModel.fetchAlerts()
        alertCollectionController.alertModels = alertModels
        alertCollection.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    lazy var viewModel: WxCellVM = WxCellVM()
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        
        //return 10
        return viewModel.cellModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WxCell", for: indexPath) as? WxViewCell
        
        //let dayForecast = forecastElements()
        cell?.delegate = self
        // Configure the cell
        cell?.backgroundColor = generateRandomPastelColor(withMixedColor: .cyan)
        
        // if viewModel.isValidJSON() == true {
        cell?.displayWeather(forecast: viewModel.cellModels[indexPath.row])
        // } else {
        // Fetch valid JSON
        // Add activity indicator
        // Wait for db writing to be complete
        //  cell?.displayWeather(forecast: viewModel.cellModels[indexPath.row])
        //}
        
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
    /*
    @objc func onTap(_ sender: UITapGestureRecognizer) -> Void {
        
        alertDetailView?.backgroundColor = (alertDetailView?.backgroundColor == UIColor.yellow) ? .green : .yellow
        // self.navigationController.performSegue(withIdentifier: "alertDetailViewSegue", sender: self)
    } */
    
    /*
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("Weather Controller touchesBegan")
    }*/
    
    func performAlertViewSegue() {
        print("performAlertViewSegue")
        
       // let pageViewController = storyboard?.instantiateViewController(withIdentifier: "pageViewController") as! PageViewController
       // let pageViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "pageViewController") as! PageViewController
        for model in alertModels {
            guard let viewController = AlertDetailViewModel(alertModel: model).createViewController() else { return }
            pages.array.append(viewController)
        }
        //pageViewController.pages = pages
       // self.navigationController?.pushViewController(pageViewController, animated: true)
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

}
