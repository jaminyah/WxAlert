//
//  WeatherController.swift
//  WxAlert
//
//  Created by macbook on 3/20/18.
//  Copyright © 2018 Jaminya. All rights reserved.
//

import UIKit

class WeatherController: UIViewController {
    
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
    
    var pages = Pages()
    var alertModels: [AlertModel] = []
    
    override func viewDidLoad() {
        print("Weather Controller")
        
        super.viewDidLoad()
        self.delegate = rootController
        
        // Set data source and delegate
        alertCollection.dataSource = alertCollectionController
        alertCollection.delegate = alertCollectionController
        
 
        wxCollection.dataSource = wxCollectionController
        wxCollection.delegate = wxCollectionController
        
        // hide views
        alertCollection.isHidden = false
        navigationController?.navigationBar.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        selectedCity = self.delegate?.getSelectedCity()
        cityLabel.text = selectedCity.name + ", " + selectedCity.state
        wxCollectionController.viewModel = WxCellVM()
        wxCollection.reloadData()
        let alertViewModel = AlertViewModel()
        alertCollectionController.alertModels = alertViewModel.fetchAlerts()
        alertCollection.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        /*
        alertModels = alertViewModel.fetchAlerts()
        for model in alertModels {
            guard let viewController = AlertDetailViewModel(alertModel: model).createViewController() else { return }
            pages.array.append(viewController)
        }
        */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    

    
 

    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destinationVC = segue.destination as? PageViewController {
            destinationVC.pages.array = pages.array
        }
    }

}
