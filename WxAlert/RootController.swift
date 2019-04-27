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
    let dbmgr = DbMgr.sharedInstance
    var dataManager: DataManager?
    var selectedCity = SelectedCity()
    var networkMgr = NetworkMgr()
    var pointsAPIJson: Any? = nil

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
        
        // Check if necessary
        //NotificationCenter.default.post(name: .refreshCityNames, object: nil)
        
        // Update properties of city to be displayed
        if let cityCount = dataManager?.cityCount() {
            selectedCity.arrayIndex = cityCount - 1
        }
        
        // Debug info
        selectedCity.name = city.cityName
        selectedCity.state = city.region.state
        print("Selected City name: \(selectedCity.name) index: \(selectedCity.arrayIndex) timeFrame: \(selectedCity.timeFrame.rawValue)")
        
        //var wxTable: String = city.cityName.replacingOccurrences(of: " ", with: "_")
        //wxTable = wxTable + "_" + city.region.state
        
        // Add a new database table to cities_usa.sqlite
        let wxTable = StringUtils.concat(name: selectedCity.name, state: selectedCity.state)
        dbmgr.dropTable(name: wxTable)
        dbmgr.createWx(table: wxTable)
        
        let alertTable = "alert_" + wxTable
        dbmgr.dropTable(name: alertTable)
        dbmgr.createAlert(table: alertTable)
        
        networkMgr = NetworkMgr(cityObject: city)
        self.networkMgr.getNWSPointsJSON(completion: self.sqliteWrite)
        /*
        let notice = StringUtils.concat(name: city, state: stateID)
        let didUpdate = Notification.init(name: notice, enabled: true)
        // NotificationCenter.default.post(name: .didUpdateWeather, object: self, userInfo: citySender)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: didUpdate.name), object: self, userInfo: citySender)
        */
        let location = StringUtils.concat(name: selectedCity.name, state: selectedCity.state)
        let didUpdateWx = Notification.init(name: location, enabled: true)
        
        // Start Timer to fetch new wx data
        NotificationCenter.default.addObserver(self, selector: #selector(startWxRefreshClock(_:)), name: NSNotification.Name(rawValue: didUpdateWx.name), object: nil)

    }
    
    private func sqliteWrite(data: Any) -> Void {
        print("Received data")

        let baseKey = selectedCity.name + selectedCity.state
        var wxKey = baseKey + "wx"
        wxKey = wxKey.lowercased()
        var alKey = baseKey + "al"
        alKey = alKey.lowercased()
        
        let url = parsePointsForecast(json: data)
        let zoneUrl = parsePointsCounty(json: data)
        
        print("wx url: \(url!)")
        print("al url: \(zoneUrl)")
        
        if let pathUrl = url {
            let path = pathUrl.absoluteString
            PlistMgr.addToPlist(key: wxKey, value: path)
        }
        PlistMgr.addToPlist(key: alKey, value: zoneUrl)
        
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1                  // Create serial queue
        queue.addOperation {
            self.networkMgr.getForecastJSON(forecastUrl: url)
        }
        queue.addOperation {
            self.networkMgr.getAlertJSON(url: zoneUrl)
        }
        queue.waitUntilAllOperationsAreFinished()

    }
    
    private func parsePointsForecast(json: Any) -> URL? {
        var forecastUrl: URL? = nil
        
        if let jsonParser = PointsJsonParser(JSON: json) {
            let urlString = jsonParser.forecastUrl
            forecastUrl = URL(string: urlString)
            
        }
        return forecastUrl
        // Generate 503 error for testing
        // let tempUrl = URL(string: "http://coder.jaminix.net/")
        // return tempUrl
    }
    
    private func parsePointsCounty(json: Any) -> String {
        var countyUrl: String = ""
        
        if let jsonParser = PointsJsonParser(JSON: json) {
            countyUrl = jsonParser.countyUrl
        }
        print("countyUrl: \(countyUrl)")
        return countyUrl
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
    
    @objc func startWxRefreshClock(_ notification: NSNotification) {
        print("startWxRefreshClock")

        let city = selectedCity.name
        let stateID = selectedCity.state
        let location = StringUtils.concat(name: city, state: stateID)
        
        if let object = notification.userInfo as? [String: String] {
            for (cityName, stateCode) in object {
                let sender = StringUtils.concat(name: cityName, state: stateCode)
                if sender == location {
                    DispatchQueue.main.async {
                        print("Starting countdown timer:, \(city), \(stateID)")
                    }
                }
            }
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
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
