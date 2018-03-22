//
//  RootController.swift
//  WxAlert
//
//  Created by macbook on 3/20/18.
//  Copyright © 2018 Jaminya. All rights reserved.
//

import UIKit

class RootController: UITabBarController, CityProtocol {
    
    let dataManager = DataManager.sharedInstance

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
        
        self.dataManager.appendCityObject(newCity: city)
        NotificationCenter.default.post(name: .refreshCityNames, object: nil)
        
        // Show city count
       // print("New city count: \(self.dataManager.cityCount())")
    }
    
    func showCities() {
        self.dataManager.showCities()
    }
    
    func getNameOfCities() -> [String] {
        return self.dataManager.getCityNames()
    }
    
    func getCityArray() -> [City] {
        return dataManager.getCityArray()
    }
    
    
    func getCityCount() -> (Int) {
        return dataManager.cityCount()
    }
    
    func deleteCity(name: String) {
        self.dataManager.removeCity(cityName: name)
        
        NotificationCenter.default.post(name: CITY_LIST_MODIFIED, object: nil)
        
        // Debug
        self.dataManager.showCities()
    }
    
    func setNotifications(name: String, newSettings: Notification, position: Int) ->() {
        self.dataManager.updateNotifications(cityName: name, settings: newSettings, index: position)
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
