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
    
    let dbmgr = DbMgr.sharedInstance
    var cellModels: [CellModel] = []
    
    init() {
        var delegate: CityProtocol?
        let rootController = RootController.sharedInstance
        delegate = rootController
        
        let selectedCity = delegate?.getSelectedCity()
        let timePeriod = selectedCity?.timeFrame.hashValue
        
        var tableName = selectedCity!.name.replacingOccurrences(of: " ", with: "_") + "_" + selectedCity!.state
        tableName = tableName.lowercased()
        
        self.cellModels = fetchForecast(timeFrame: timePeriod!, table: tableName)
    }
    
    private func fetchForecast(timeFrame: Int, table: String) ->[CellModel] {
        print("fetchForecast: read from sqlite ...")
        
        // TODO - Populate properties from sqlite db
        // read day = 0, day+night = 1, night = 2 settings from delegate
        
        var weatherData: [CellModel] = []
        var query: String
        
        switch (timeFrame) {
        case 0:
            query = "SELECT * FROM \(table) WHERE isDayTime == 1;"
            weatherData = dbmgr.DayForecast(from: table, sql: query)
            
        case 1:
            query = "SELECT * FROM \(table);"
            weatherData = dbmgr.DayNightForecast(sql: query)
        
        case 2:
            query = "SELECT * FROM \(table) WHERE isDayTime == 0;"
            weatherData = dbmgr.NightForecast(sql: query)
            
        default:
            print("Time Frame error")
        }
        return weatherData
    }
    
} // WxCellVM
