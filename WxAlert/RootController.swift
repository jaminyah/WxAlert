//
//  RootController.swift
//  WxAlert
//
//  Created by macbook on 3/20/18.
//  Copyright © 2018 Jaminya. All rights reserved.
//

import UIKit

class RootController: UITabBarController, CityProtocol {
    
    static let sharedInstance = RootController()
    var dataManager: DataManager?
    var selectedCity = SelectedCity()
    
    // Inject DataManager dependency into root controller singleton
    
     private init(dataManager: DataManager = .sharedInstance) {
        super.init(nibName: nil, bundle: nil)
        self.dataManager = dataManager
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
     
    override func viewDidLoad() {
        super.viewDidLoad()

        // App initial startup - Disable weather and settings tab
        tabBar.items?[1].isEnabled = false
        tabBar.items?[2].isEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addNewCity(city: City) {
        print("AddNewCity: ")
        self.dataManager?.appendCityObject(newCity: city)
        NotificationCenter.default.post(name: .refreshCityNames, object: nil)
        
        // Update properties of city to be displayed
        if let cityCount = dataManager?.cityCount() {
            selectedCity.arrayIndex = cityCount - 1
        }
        selectedCity.name = city.cityName
        selectedCity.state = city.region.state
        
        print("SelectedCity name: \(selectedCity.name) index: \(selectedCity.arrayIndex) timeFrame: \(selectedCity.timeFrame.rawValue)")
        
        // Add a new database table to cities_usa.sqlite
        //let dbmgr = DbMgr.sharedInstance
        //dbmgr.createDbTable(city: city.cityName, state: city.region.state)
        
        let networkmgr = NetworkMgr.sharedInstance
       // networkmgr.getForecastJSON(city: city.cityName, state: city.region.state)
        
    }
    
    func showCities() {
        self.dataManager?.showCities()
    }
    
    func getNameOfCities() -> [String] {
        guard let cityNames = self.dataManager?.getCityNames() else {
            return []
            
        }
        return cityNames
    }
    
    func getCityArray() -> [City] {
        guard let cityArray = dataManager?.getCityArray() else {
            return []
        }
        return cityArray
    }
    
    
    func getCityCount() -> (Int) {
        
        guard let cityCount = dataManager?.cityCount() else {
            return 0
        }
        return cityCount
    }
    
    func deleteCity(name: String) {
        self.dataManager?.removeCity(cityName: name)
        
        NotificationCenter.default.post(name: CITY_LIST_MODIFIED, object: nil)
        
        // Debug
        self.dataManager?.showCities()
    }
    
    func setNotifications(city: City) ->() {
        self.dataManager?.updateNotifications(cityObject: city)
    }
    
    func setSelectedCity(city: City, index: Int) ->() {
        print("setSelectedCity")
        selectedCity.name = city.cityName
        selectedCity.state = city.region.state
        selectedCity.arrayIndex = index
        print("city name: \(selectedCity.name) index: \(selectedCity.arrayIndex) timeFrame: \(selectedCity.timeFrame.rawValue)")
    }
    
    func getSelectedCity() -> SelectedCity {
        return selectedCity
    }
    
    func setTimeFrame(timeFrame: TimeFrame) {
        selectedCity.timeFrame = timeFrame
        
        print("RootCtrl: \(selectedCity.timeFrame.rawValue)")
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
