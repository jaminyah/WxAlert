//
//  UpdateMgr.swift
//  WxAlert
//
//  Created by macbook on 4/23/19.
//  Copyright © 2019 Jaminya. All rights reserved.
//

import Foundation

class UpdateMgr {
    
    class func fetchLatestWeather(cityName: String, stateUS: String) -> Void {
        
        let weatherUrl = PlistMgr.wxURL(city: cityName, stateID: stateUS)
        let weatherOpQ = WeatherOpQueue(with: weatherUrl, city: cityName, stateID: stateUS)
        weatherOpQ.executeOps()
    }
    
    class func fetchLatestAlerts(cityName: String, stateUS: String) -> Void {
        
        
    }
}
