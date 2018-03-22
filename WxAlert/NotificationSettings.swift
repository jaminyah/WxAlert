//
//  NotificationSettings.swift
//  WxAlert
//
//  Created by macbook on 3/20/18.
//  Copyright © 2018 Jaminya. All rights reserved.
//

import UIKit

class NotificationSettings: UITableViewController {

    var notifications = [Notification]()
    var city = City()
    
    let rootController = RootController()
    var delegate: CityProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        
        tableView.allowsMultipleSelection = true
        self.delegate = rootController
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
       self.notifications = city.notificationList
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return ONE_SECTION
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.notifications.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notificationCell", for: indexPath)
        
        cell.textLabel?.text = self.notifications[indexPath.row].name
        
        // Show saved notification settings
        if self.notifications[indexPath.row].enabled == true {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectAt: ")
        if let cell = tableView.cellForRow(at: indexPath) {
            if cell.isSelected {
                cell.accessoryType = .checkmark
                
                // Change notification settings in city object
                self.notifications[indexPath.row].enabled = true
                let notification = self.notifications[indexPath.row]
                self.delegate?.setNotifications(name: city.cityName, newSettings: notification, position: indexPath.row)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print("didDeselectRowAt: ")
        if let cell = tableView.cellForRow(at: indexPath) {
            
            cell.accessoryType = .none
            
            // Change notification settings in city object
            self.notifications[indexPath.row].enabled = false
            let notification = self.notifications[indexPath.row]
            self.delegate?.setNotifications(name: city.cityName, newSettings: notification, position: indexPath.row)
            
        }
    }
    
}
