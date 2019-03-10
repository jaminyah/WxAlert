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
    
    override func viewDidLoad() {
        print("Weather Controller")
        
        super.viewDidLoad()
        self.delegate = rootController
        
        // Do any additional setup after loading the view.
        // Set data source and delegate
        alertCollection.dataSource = alertCollectionController
        alertCollection.delegate = alertCollectionController
        
        //cityCollection.dataSource = cityCollectionController
        //cityCollection.delegate = cityCollectionController
        
        wxCollection.dataSource = wxCollectionController
        wxCollection.delegate = wxCollectionController
        
        // hide views
        alertCollection.isHidden = false
        navigationController?.navigationBar.isHidden = true

        
        /*
        let queue = OperationQueue()
        queue.addOperation {
            // Monitor JSON valid datetime.
            self.monitorWxTimestamp()
        }
        queue.waitUntilAllOperationsAreFinished()
        */
        
        /* Running before network data is fetched
        DispatchQueue.global(qos: .background).async {
            self.monitorWxTimestamp()
        }
        */
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        selectedCity = self.delegate?.getSelectedCity()
        cityLabel.text = selectedCity.name + ", " + selectedCity.state
        wxCollectionController.viewModel = WxCellVM()
        wxCollection.reloadData()
        alertCollectionController.viewModel = AlertViewModel()
        alertCollection.reloadData()
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
    

    
 
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
