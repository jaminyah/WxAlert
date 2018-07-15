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
    var settingCity = City()
    var delegate: CityProtocol?
    let rootController = RootController()
    
    // Inject RootController dependency
   /*
    var rootController: RootController?

    init(rootController: RootController) {
        super.init(nibName: nil, bundle: nil)
        self.rootController = rootController
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.allowsMultipleSelection = true
        self.delegate = rootController
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
       self.notifications = settingCity.notificationList
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.settingCity.notificationList = notifications
        self.delegate?.setNotifications(city: settingCity)
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
                self.notifications[indexPath.row].enabled = true
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print("didDeselectRowAt: ")
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
            self.notifications[indexPath.row].enabled = false
        }
    }

}
