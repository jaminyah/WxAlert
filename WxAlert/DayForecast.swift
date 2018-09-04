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
        
        if let number = JSON["number"] as? Int { self.number = number } else { self.number = 0 }
        if let name = JSON["name"] as? String { self.name = name } else { self.name = "null" }
        if let startTime = JSON["startTime"] as? String { self.startTime = startTime } else { self.startTime = EPOCH_TIME_REFERENCE }
        if let endTime = JSON["endTime"] as? String { self.endTime = endTime } else { self.endTime = EPOCH_TIME_REFERENCE }
        if let isDaytime = JSON["isDaytime"] as? Bool { self.isDaytime = isDaytime } else { self.isDaytime = false }
        if let temperature = JSON["temperature"] as? Int { self.temperature = temperature } else { self.temperature = -99 }
        if let temperatureUnit = JSON["temperatureUnit"] as? String { self.temperatureUnit = temperatureUnit } else { self.temperatureUnit = "-" }
        if let temperatureTrend = JSON["temperatureTrend"] as? String { self.temperatureTrend = temperatureTrend } else { self.temperatureTrend = "null"}
        if let windSpeed = JSON["windSpeed"] as? String { self.windSpeed = windSpeed } else { self.windSpeed = "--- mph" }
        if let windDirection = JSON["windDirection"] as? String { self.windDirection = windDirection  }else { self.windDirection = "--" }
        if let icon = JSON["icon"] as? String { self.icon = icon } else { self.icon = "placeholder" }
        if let shortForecast = JSON["shortForecast"] as? String { self.shortForecast = shortForecast } else { self.shortForecast = "-" }
        if let detailedForecast = JSON["detailedForecast"] as? String { self.detailedForecast = detailedForecast } else { self.detailedForecast = "-" }
        
    }
}
