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
    let dbMgr = DbMgr.sharedInstance
    let cityName: String
    let stateCode: String

    init(forecast: WeekForecast, cityName: String, stateCode: String) {
        self.forecast = forecast
        self.cityName = cityName
        self.stateCode = stateCode
    }
        
    func writeForecast() -> Void {

        guard let data = forecast?.periods else { return }
        dbMgr.insert(sevenDay: data, city: cityName, stateID: stateCode)
    }
    
} // ForecastDataMgr
