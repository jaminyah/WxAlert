//
//  AppSettingController.swift
//  WxAlert
//
//  Created by macbook on 3/20/18.
//  Copyright © 2018 Jaminya. All rights reserved.
//

import UIKit

class AppSettingController: UITableViewController {
    
    var appSettings = ["City List", "City Edit"]
    
    var delegate: CityProtocol?
    let rootController = RootController.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = rootController
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return self.appSettings.count
        var count = 0
        switch (section){
        case 0:
            count = 1
        case 1:
            count = 1
        case 2:
            guard let rowCount = self.delegate?.getCityCount() else {
                return 0
            }
            return rowCount
        default:
            count = 0
        }
        return count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "appSettingsCell", for: indexPath)
        
        switch (indexPath.section){
        case 0:
            cell.textLabel?.text = appSettings[0]
        case 1:
            cell.textLabel?.text = appSettings[1]
        case 2:
            cell.textLabel?.text = "weather selection"
        default:
            cell.textLabel?.text = "default"
        }
        //cell.textLabel?.text = appSettings[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cityListView = self.storyboard?.instantiateViewController(withIdentifier: "CityListView") as! CityListController
        let cityEditView = self.storyboard?.instantiateViewController(withIdentifier: "CityEditView") as! CityEditController
        
        switch indexPath.row {
        case 0:
            print("Push Notifications View")
            self.navigationController?.pushViewController(cityListView, animated: true)
        case 1:
            self.navigationController?.pushViewController(cityEditView, animated: true)
        default:
            print("Show Add City View")
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title: String?
        
        switch section {
        case 0:
            title = "Notifications"
        case 1:
            title = "Edit City List"
        case 2:
            title = "Weather Selection"
        default:
            title = nil
        }
        return title
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
