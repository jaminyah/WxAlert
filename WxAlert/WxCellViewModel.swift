//
//  WxCellViewModel.swift
//  WxAlert
//
//  Created by macbook on 8/12/18.
//  Copyright © 2018 Jaminya. All rights reserved.
//

import Foundation
import UIKit

class WxCellVM {
    
    var dbmgr = DbMgr.sharedInstance
    var cellModels = [CellModel]()
    var lowTemperature = [String]()
    
    private var timeFrame: Int!
    private var table: String
    
    // Create an init method to take db table name as parameter
    init() {
        var delegate: CityProtocol?
        let rootController = RootController.sharedInstance
        delegate = rootController
        
        let selectedCity = delegate?.getSelectedCity()
        timeFrame = selectedCity?.timeFrame.hashValue
        
        //var tableName: String = city.cityName.replacingOccurrences(of: " ", with: "_")
        //tableName = tableName + "_" + city.region.state
        self.table = selectedCity!.name.replacingOccurrences(of: " ", with: "_") + "_" + selectedCity!.state
    }
    
    func fetchForecast() ->Void {
        print("fetchForecast: read from sqlite ...")
        
        // TODO - Populate properties from sqlite db
        // read day, night, day-night settings from delegate
        var query: String
        switch (timeFrame) {
        case 0:
           // query = "SELECT Name, Temperature, WindSpeed, WindDirection, Icon, ShortForecast FROM \(self.table) WHERE isDayTime == 1;"
            query = "SELECT * FROM \(self.table) WHERE isDayTime == 1;"
            cellModels = dbmgr.readForecast(from: self.table.lowercased(), sql: query)
            
            //let query2 = "SELECT Temperature FROM \(self.table.lowercased()) WHERE isDayTime == 0"
           // lowTemperature = dbmgr.readLowTemperature(from: query2)
            
        case 1:
            query = "SELECT Name, Temperature, WindSpeed, WindDirection, Icon, ShortForecast FROM \(self.table);"
            cellModels = dbmgr.readForecast(from: self.table.lowercased(), sql: query)
        
        case 2:
            query = "SELECT Name, Temperature, WindSpeed, WindDirection, Icon, ShortForecast FROM \(self.table) WHERE isDayTime == 0;"
            cellModels = dbmgr.readForecast(from: table.lowercased(), sql: query)
            
        default:
            print("Time Frame error")
        }
    }
    
} // WxCellVM
