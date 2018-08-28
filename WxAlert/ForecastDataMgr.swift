//
//  ForecastDataMgr.swift
//  WxAlert
//
//  Created by macbook on 8/28/18.
//  Copyright © 2018 Jaminya. All rights reserved.
//

import Foundation

class ForecastDataMgr {
    
    var weekForecast: WeekForecast?
    
    init(weekForecast: WeekForecast) {
        self.weekForecast = weekForecast
    }
    
    func writeForecast() {
        // TODO - Write to database
        print("Writing forecast to database.")
        
    }
    
    func readForecast() {
        // TODO - 
    }
}
