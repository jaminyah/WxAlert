//
//  CityListController.swift
//  WxAlert
//
//  Created by macbook on 3/20/18.
//  Copyright © 2018 Jaminya. All rights reserved.
//

import UIKit

class CityListController: UITableViewController {

    //let rootController = RootController()
    let rootController = RootController.sharedInstance
    var delegate: CityProtocol?
    var cityArray = [City]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = rootController
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getUpdatedCityListData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getUpdatedCityListData() {
        if let list = self.delegate?.getCityArray() {
            self.cityArray = list
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return ONE_SECTION
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cityArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityNameCell", for: indexPath)
        
        let city = cityArray[indexPath.row]
        let cityState = city.cityName + ", " + city.region.state
        
        cell.textLabel?.text = cityState
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "settingSegue", sender: self)
    }
    
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "settingSegue" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let selectedCity = cityArray[indexPath.row]
                let settingsController = segue.destination as? NotificationSettings
                settingsController?.settingCity = selectedCity
            }
        }
    }
}
