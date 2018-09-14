//
//  WeekForecast.swift
//  WxAlert
//
//  Created by macbook on 8/28/18.
//  Copyright © 2018 Jaminya. All rights reserved.
//

import Foundation

struct WeekForecast {
    
    private(set) var validTimes: String = EPOCH_TIME_REFERENCE           // readonly property
    private(set) var periods: [DayForecast] = []                         // readonly property
    
    init(validTimes: String, periods: [DayForecast]) {
        self.validTimes = validTimes
        self.periods = periods
    }
}

extension WeekForecast: JSONDecodable {
    
    init?(JSON: Any) {
        guard let JSON = JSON as?  [String: AnyObject] else { return nil }

        if let validTimes = JSON["properties"]?["validTimes"] as? String { self.validTimes = validTimes} else { self.validTimes = EPOCH_TIME_REFERENCE}
        guard let periods = JSON["properties"]?["periods"] as? [[String: AnyObject]] else { return nil }
        
        var buffer = [DayForecast]()
        
        for dailyForecast in periods {
            if let weatherData = DayForecast(JSON: dailyForecast) {
                buffer.append(weatherData)
               // print("Time period: \(weatherData.name), Temp trend: \(weatherData.temperatureTrend)")
            }
        }
        self.periods = buffer
    }
}

