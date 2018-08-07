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
    var cityArray = [City]()
    
    var delegate: CityProtocol?
    let rootController = RootController.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = rootController
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("App Setting view will appear")
        getUpdatedCityListData()
        self.tableView.reloadData()
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
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return self.appSettings.count
        print("NumberofRowsInSection")
        var count = 0
        switch (section){
        case 0:
            count = 1
        case 1:
            count = 1
        case 2:
            count = 1
        case 3:
            guard let rowCount = self.delegate?.getCityCount() else {
                return 0
            }
            print("appSetting rowCount: \(rowCount)")
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
        case 3:
            let city = cityArray[indexPath.row]
            let cityState = city.cityName + ", " + city.region.state
            cell.textLabel?.text = cityState
        default:
            cell.textLabel?.text = ""
        }
        //cell.textLabel?.text = appSettings[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cityListView = self.storyboard?.instantiateViewController(withIdentifier: "CityListView") as! CityListController
        let cityEditView = self.storyboard?.instantiateViewController(withIdentifier: "CityEditView") as! CityEditController
        
        switch indexPath.section {
        case 0:
            print("Push Notifications View")
            self.navigationController?.pushViewController(cityListView, animated: true)
        case 1:
            self.navigationController?.pushViewController(cityEditView, animated: true)
        case 3:
            if let cell = tableView.cellForRow(at: indexPath) {
                cell.accessoryType = .checkmark
            }
        default:
            print("Show Add City View")
        }
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            if let cell = tableView.cellForRow(at: indexPath) {
                cell.accessoryType = .none
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title: String?
        
        switch section {
        case 0:
            title = "Set Notifications"
        case 1:
            title = "Remove City"
        case 2:
            title = "Time Frame"
        case 3:
            title = "Select City"
        default:
            title = nil
        }
        return title
    }
    
    // Mark: UITableViewDelegate
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var view: UIView? = UIView()
        
        let labelView = UILabel(frame: CGRect(x: 20, y: 5, width: tableView.frame.width - 20, height: 30))
        //labelView.backgroundColor = .gray
        labelView.font = UIFont.boldSystemFont(ofSize: labelView.font.pointSize)
        labelView.text = "Time Frame"
        
        view?.backgroundColor = .white
        let segmentedControl = UISegmentedControl(frame: CGRect(x: 10, y: 5, width: tableView.frame.width - 20, height: 30))
        //let segmentedControl = UISegmentedControl(frame: CGRect(x: 10, y: 35, width: tableView.frame.width - 20, height: 30))
        segmentedControl.insertSegment(withTitle: "Day", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "Day + Night", at: 1, animated: false)
        segmentedControl.insertSegment(withTitle: "Night", at: 2, animated: false)
        
        switch section {
        case 2:
            //view?.addSubview(labelView)
            view?.addSubview(segmentedControl)
        default:
            view = nil
        }
        return view
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
