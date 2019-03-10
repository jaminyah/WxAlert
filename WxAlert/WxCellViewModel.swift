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
    
    private (set) var cellModels: [CellModel] = []
    var table: String = String()
    
    override init() {
        super.init()
        self.cellModels = fetchForecast()
    }
    
   func fetchForecast() -> [CellModel] {
        print("fetchForecast: read from sqlite ...")
                
        var query: String
        var weatherData: [CellModel] = []
    
        let timeframe = selectedCity.timeFrame
        self.table = tableName.lowercased()
    
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
    
    func monitorTimestamp() {
        // Start a thread to monitor timestamp validity
        // Raise and event when invalid
    }
    
} // WxCellVM
