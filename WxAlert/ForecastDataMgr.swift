//
//  ForecastDataMgr.swift
//  WxAlert
//
//  Created by macbook on 8/28/18.
//  Copyright © 2018 Jaminya. All rights reserved.
//

import Foundation

class ForecastDataMgr {
    
    var forecast: WeekForecast?
    var table: String?
    let dbMgr = DbMgr.sharedInstance
    
    init(forecast: WeekForecast, table: String) {
        self.forecast = forecast
        self.table = table
    }
        
    func writeForecast() -> Void {

        guard let data = forecast?.periods else { return }
        guard let tableName = self.table else { return }
        dbMgr.insertSevenDay(weather: data, table:tableName)
 
    }
    
} // ForecastDataMgr
