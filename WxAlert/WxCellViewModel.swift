//
//  WxCellViewModel.swift
//  WxAlert
//
//  Created by macbook on 8/12/18.
//  Copyright © 2018 Jaminya. All rights reserved.
//

import Foundation
import UIKit

struct WxCellVM {
    
    let dbmgr = DbMgr.sharedInstance
    private (set) var day: String = "Mon"
    private (set) var wxIcon: UIImage = #imageLiteral(resourceName: "Sun")
    private (set) var alertIcon: UIImage = #imageLiteral(resourceName: "alert")
    private (set) var rain: String = "0 %"
    private (set) var windSpeed: String = "0 mph"
    private (set) var windDirection: String = "N"
    private (set) var hiTemp: String = "0 F"
    private (set) var lowTemp: String = "0 F"
    
    private var timeFrame: Int!
    private var table: String
    
    // Create an init method to take db table name as parameter
    init() {
        var delegate: CityProtocol?
        let rootController = RootController.sharedInstance
        delegate = rootController
        
        let selectedCity = delegate?.getSelectedCity()
        timeFrame = selectedCity?.timeFrame.hashValue
        
        self.table = selectedCity!.name.replacingOccurrences(of: " ", with: "_")
    }
    
    func fetchForecast() ->Void {
        // TODO - Populate properties from sqlite db
        // read day, night, day-night settings from delegate
        var query: String
        switch (timeFrame) {
        case 0:
            query = "SELECT Name, Temperatrue, WindSpeed, WindDirection, Icon, ShortForecast FROM \(self.table) WHERE isDayTime == 1;"
            setData(sql: query)
            
            let query2 = "SELECT Temperature FROM \(self.table) WHERE isDayTime == 0"
            setLowTemperature(sql: query2)
            
        case 1:
            query = "SELECT Name, Temperatrue, WindSpeed, WindDirection, Icon, ShortForecast FROM \(self.table);"
            setData(sql: query)
        
        case 2:
            query = "SELECT Name, Temperatrue, WindSpeed, WindDirection, Icon, ShortForecast FROM \(self.table) WHERE isDayTime == 0;"
            setData(sql: query)
            
        default:
            print("Time Frame error")
        }
    }
    
    private func setData(sql: String) {
        // TODO - Read sqlite, populate properties
    }
    
    private func setLowTemperature(sql: String) {
        // TODO - Read sqlite night-time temperature, set low temperature property
    }
}
