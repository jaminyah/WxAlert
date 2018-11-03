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
        self.cellModels = fetchForecast()
    }
    
    func fetchForecast() ->[CellModel] {
        print("fetchForecast: read from sqlite ...")
        
        var delegate: CityProtocol?
        let rootController = RootController.sharedInstance
        delegate = rootController
        
        let selectedCity = delegate?.getSelectedCity()
        let timePeriod = selectedCity?.timeFrame
        print("timePeriod: \(timePeriod!)")
        
        var table = selectedCity!.name.replacingOccurrences(of: " ", with: "_") + "_" + selectedCity!.state
        table = table.lowercased()
        
        // TODO - Populate properties from sqlite db
        // read day = 0, day+night = 1, night = 2 settings from delegate
        
        var weatherData: [CellModel] = []
        var query: String
        
        switch (timePeriod!) {
        case .Day:
            query = "SELECT * FROM \(table) WHERE isDayTime == 1;"
            weatherData = dbmgr.DayForecast(from: table, sql: query)
            
        case .DayNight:
            query = "SELECT * FROM \(table);"
            weatherData = dbmgr.DayNightForecast(sql: query)
        
        case .Night:
            query = "SELECT * FROM \(table) WHERE isDayTime == 0;"
            weatherData = dbmgr.NightForecast(sql: query)
            
        }
        return weatherData
    }
    
} // WxCellVM
