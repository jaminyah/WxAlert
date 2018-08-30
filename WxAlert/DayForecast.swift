//
//  ForecastModel.swift
//  WxAlert
//
//  Created by macbook on 8/28/18.
//  Copyright © 2018 Jaminya. All rights reserved.
//

import Foundation

struct DayForecast: JSONDecodable {
    
    var number: Int
    var name: String
    var startTime: String
    var endTime: String
    var isDaytime: Bool
    var temperature: Int
    var temperatureUnit: String
    var temperatureTrend: String
    var windSpeed: String
    var windDirection: String
    var icon: String
    var shortForecast: String
    var detailedForecast: String
    
    init?(JSON: Any) {
        
        guard let JSON = JSON as? [String: AnyObject] else { return nil }
        
        guard let number = JSON["number"] as? Int else { return nil }
        guard let name = JSON["name"] as? String else { return nil }
        guard let startTime = JSON["startTime"] as? String else { return nil }
        guard let endTime = JSON["endTime"] as? String else { return nil }
        guard let isDaytime = JSON["isDaytime"] as? Bool else { return nil }
        guard let temperature = JSON["temperature"] as? Int else { return nil }
        guard let temperatureUnit = JSON["temperatureUnit"] as? String else { return nil }
        //guard let temperatureTrend = JSON["temperatureTrend"] as? String else { return nil }
        if let temperatureTrend = JSON["temperatureTrend"] as? String { self.temperatureTrend = temperatureTrend } else { self.temperatureTrend = "null"}
        guard let windSpeed = JSON["windSpeed"] as? String else { return nil }
        guard let windDirection = JSON["windDirection"] as? String else { return nil }
        guard let icon = JSON["icon"] as? String else { return nil }
        guard let shortForecast = JSON["shortForecast"] as? String else { return nil }
        guard let detailedForecast = JSON["detailedForecast"] as? String else { return nil }
        
        self.number = number
        self.name = name
        self.startTime = startTime
        self.endTime = endTime
        self.isDaytime = isDaytime
        self.temperature = temperature
        self.temperatureUnit = temperatureUnit
        //self.temperatureTrend = temperatureTrend
        self.windSpeed = windSpeed
        self.windDirection = windDirection
        self.icon = icon
        self.shortForecast = shortForecast
        self.detailedForecast = detailedForecast
        
    }
}
