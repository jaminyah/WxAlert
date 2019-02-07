//
//  WxCellVM.swift
//  Wx Cell ViewModel
//  WxAlert
//
//  Created by macbook on 8/12/18.
//  Copyright © 2018 Jaminya. All rights reserved.
//

import Foundation
// import UIKit

class WxCellVM: CellViewModel {
    
    //let dbmgr = DbMgr.sharedInstance
    private (set) var cellModels: [CellModel] = []
    var table: String = ""
    
    //let rootController = RootController.sharedInstance
    //var delegate: CityProtocol? = nil
    
    override init() {
        //delegate = rootController
        super.init()
        self.cellModels = fetchForecast()
    }
    
    
   func fetchForecast() ->[CellModel] {
        print("fetchForecast: read from sqlite ...")
                
        var query: String
        var weatherData: [CellModel] = []
        
        let selectedCity = delegate?.getSelectedCity()
        let tableName = selectedCity!.name.replacingOccurrences(of: " ", with: "_") + "_" + selectedCity!.state
        let period = selectedCity?.timeFrame
        
        // Set property values
        self.table = tableName.lowercased()
        let timeframe = period!
    
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
        //self.cellModels = weatherData
    }
    
    func isValidJSON() -> Bool {
        // TODO -
        
        let query = "SELECT EndTime FROM \(table) WHERE Number == 1;"
        let isValid = dbmgr.checkJSONValid(sql: query)
        return isValid
    }
    
    func monitorTimestamp() {
        // Start a thread to monitor timestamp validity
        // Raise and event when invalid
    }
    
} // WxCellVM
