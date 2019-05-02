//
//  WeatherController.swift
//  WxAlert
//
//  Created by macbook on 3/20/18.
//  Copyright © 2018 Jaminya. All rights reserved.
//
//  Color converter: https://www.uicolor.xyz/#/hex-to-ui

import UIKit

class WeatherController: UIViewController, UICollectionViewDataSource, GestureProtocol {
    
    @IBOutlet weak var alertCollection: UICollectionView!
    @IBOutlet weak var wxCollection:  UICollectionView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    let rootController = RootController.sharedInstance
    let dbmgr = DbMgr.sharedInstance
    var delegate: CityProtocol? = nil
    
    lazy var alertCollectionController = AlertCollectionController()
    lazy var viewModel = WxCellVM()

    var cellModels: [CellModel] = []
    var selectedCity: SelectedCity!
    
    var alertModels: [AlertModel] = []
    var pages = Pages()
    
    override func viewDidLoad() {
        print("Weather Controller")
        
        super.viewDidLoad()
        let layer = CAGradientLayer()
        layer.frame = view.bounds
        let skyBlueThin = UIColor(red: 0.69, green: 0.85, blue: 1.00, alpha: 1.0)
        let skyBlueDark = UIColor(red: 0.40, green: 0.60, blue: 1.00, alpha: 1.0)
        layer.colors = [skyBlueThin.cgColor, skyBlueDark.cgColor]
        layer.startPoint = CGPoint(x:0, y:0)
        layer.endPoint = CGPoint(x: 1, y: 1)
        view.layer.insertSublayer(layer, at: 0)
        
        self.delegate = rootController
        
        // Set data source and delegate
        alertCollection.dataSource = alertCollectionController
        alertCollection.delegate = alertCollectionController
        
        wxCollection.dataSource = self
        //wxCollection.delegate = wxCollectionController
        
        // hide views
        alertCollection.isHidden = false
        

        // Register as listener to db updates.        
        NotificationCenter.default.addObserver(self, selector: #selector(updateWxData(_:)), name: .didUpdateWeather, object: nil)
        //NotificationCenter.default.addObserver(self, selector: #selector(updateAlert(_:)), name: .updateAlert, object: nil)
        
        //configureRefreshControl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        navigationController?.navigationBar.isHidden = true
        selectedCity = self.delegate?.getSelectedCity()
        cityLabel.text = selectedCity.name + ", " + selectedCity.state
        viewModel = WxCellVM()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("WxContrl, viewDidAppear")
        tabBarController?.tabBar.isHidden = false
        let alertViewModel = AlertViewModel()
        alertModels = alertViewModel.fetchAlerts()
        alertCollectionController.alertModels = alertModels
        wxCollection.reloadData()
        alertCollection.reloadData()
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
        return viewModel.cellModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WxCell", for: indexPath) as? WxViewCell
        
        cell?.delegate = self                                  // delegate must conform to GestureProtocol
        cell?.backgroundColor = generateRandomPastelColor(withMixedColor: .cyan)
        cell?.displayWeather(forecast: viewModel.cellModels[indexPath.row], models: alertModels)
        return cell!
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
    
    // MARK: - Background utility
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
    
    @objc func updateWxData(_ notification: NSNotification) {
        var city = String()
        var stateID = String()
        
        if let updateCity = self.delegate?.getSelectedCity() {
            city = updateCity.name
            stateID = updateCity.state
        }
        let location = StringUtils.concat(name: city, state: stateID)
        
        print("updateWxData, \(city), \(stateID)")
        
        if let object = notification.userInfo as? [String: String] {
            for (cityName, stateCode) in object {
                let sender = StringUtils.concat(name: cityName, state: stateCode)
                if sender == location {
                    DispatchQueue.main.async {[weak self] in
                        self?.wxCollection.reloadData()
                    }
                }
            }
        }
    }
    
    @objc func updateAlert() {
        print("updateAlert")
        alertCollection.reloadData()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    // MARK: - Refresh Control
    func configureRefreshControl() {
        
        scrollView.refreshControl = UIRefreshControl()
        scrollView.refreshControl?.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
    }
    
    @objc func handleRefresh() {
        
        UpdateMgr.fetchLatestAlerts(cityName: selectedCity.name, stateUS: selectedCity.state)
        
        DispatchQueue.main.async {
            self.scrollView.refreshControl?.endRefreshing()
        }
    }
    
} // class
