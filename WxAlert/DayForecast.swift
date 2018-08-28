//
//  ForecastModel.swift
//  WxAlert
//
//  Created by macbook on 8/28/18.
//  Copyright © 2018 Jaminya. All rights reserved.
//

import Foundation

struct DayForecast: JSONDecodable {
    
    let number: Int
    let name: String
    let startTime: String
    let endTime: String
    let isDaytime: Bool
    let temperature: Int
    let temperatureUnit: String
    let temperatureTrend: String
    let windSpeed: String
    let windDirection: String
    let icon: String
    let shortForecast: String
    let detailedForecast: String
    
    public init?(JSON: Any) {
        
        guard let JSON = JSON as? [String: AnyObject] else { return nil }
        guard let number = JSON["number"] as? Int else { return nil }
        guard let name = JSON["name"] as? String else { return nil }
        guard let startTime = JSON["startTime"] as? String else { return nil }
        guard let endTime = JSON["endTime"] as? String else { return nil }
        guard let isDaytime = JSON["isDaytime"] as? Bool else { return nil }
        guard let temperature = JSON["temperature"] as? Int else { return nil }
        guard let temperatureUnit = JSON["temperatureUnit"] as? String else { return nil }
        guard let temperatureTrend = JSON["temperatureTrend"] as? String else { return nil }
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
        self.temperatureTrend = temperatureTrend
        self.windSpeed = windSpeed
        self.windDirection = windDirection
        self.icon = icon
        self.shortForecast = shortForecast
        self.detailedForecast = detailedForecast
    }
}
