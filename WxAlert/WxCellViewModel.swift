//
//  WxCellVM.swift
//  Wx Cell ViewModel
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
    var table: String = ""
    var timeframe: TimeFrame = .Day
    
    init() {
 
        var delegate: CityProtocol?
        let rootController = RootController.sharedInstance
        delegate = rootController
        
        let selectedCity = delegate?.getSelectedCity()
        
        let tableName = selectedCity!.name.replacingOccurrences(of: " ", with: "_") + "_" + selectedCity!.state

        guard let period = selectedCity?.timeFrame else {
            return
        }
        
        // Property initializations
        self.table = tableName.lowercased()
        self.timeframe = period
        self.cellModels = fetchForecast()
    }
    
    func fetchForecast() ->[CellModel] {
        print("fetchForecast: read from sqlite ...")
                
        // TODO - Populate properties from sqlite db
        // read day = 0, day+night = 1, night = 2 settings from delegate
        //let timePeriod = selectedCity?.timeFrame
        //print("timePeriod: \(timePeriod!)")
        
        var weatherData: [CellModel] = []
        var query: String
        
        switch (timeframe) {
        case .Day:
            query = "SELECT * FROM \(table) WHERE isDayTime == 1;"
            weatherData = dbmgr.dayForecast(from: table, sql: query)
            
        case .DayNight:
            query = "SELECT * FROM \(table);"
            weatherData = dbmgr.dayNightForecast(sql: query)
        
        case .Night:
            query = "SELECT * FROM \(table) WHERE isDayTime == 0;"
            weatherData = dbmgr.nightForecast(sql: query)
            
        }
        return weatherData
    }
    
    func isValidJSON() -> Bool {
        // TODO -
        
        let query = "SELECT EndTime FROM \(table) WHERE Number == 1;"
        let isValid = dbmgr.checkJSONValid(sql: query)
        return isValid
    }
    
} // WxCellVM
