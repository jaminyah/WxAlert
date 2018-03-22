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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return ONE_SECTION
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.appSettings.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "appSettingsCell", for: indexPath)
        
        cell.textLabel?.text = appSettings[indexPath.row]
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
