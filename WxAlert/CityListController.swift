//
//  CityListController.swift
//  WxAlert
//
//  Created by macbook on 3/20/18.
//  Copyright © 2018 Jaminya. All rights reserved.
//

import UIKit

class CityListController: UITableViewController {

    let rootController = RootController()
    var delegate: CityProtocol?
    var cityArray = [City]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(refreshTableData), name: .refreshCityNames, object: nil)
        self.delegate = rootController
        getLatestCityNames()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refreshTableData() {
        // print("In CityListController: refreshCityNames")
        getLatestCityNames()
        self.tableView.reloadData()
    }
    
    func getLatestCityNames() {
        if let list = self.delegate?.getCityArray() {
            self.cityArray = list
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return ONE_SECTION
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
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
        
        // let notificationSetting = self.storyboard?.instantiateViewController(withIdentifier: "SettingsView") as! NotificationSettings
        // self.navigationController?.pushViewController(notificationSetting, animated: true)
        performSegue(withIdentifier: "settingSegue", sender: self)
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "settingSegue" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let selectedCity = cityArray[indexPath.row]
                let settingsController = segue.destination as? NotificationSettings
                settingsController?.city = selectedCity
            }
        }
    }
}
