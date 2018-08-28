//
//  WeekForecast.swift
//  WxAlert
//
//  Created by macbook on 8/28/18.
//  Copyright © 2018 Jaminya. All rights reserved.
//

import Foundation

struct WeekForecast {
    
    public var weekForecast: [DayForecast]
    
    init(weekForecast: [DayForecast]) {
        self.weekForecast = weekForecast
    }
}

extension WeekForecast: JSONDecodable {
    
    public init?(JSON: Any) {
        guard let JSON = JSON as? [String: AnyObject] else { return nil }
        guard let weeklyForecast = JSON["properties"]?["periods"] as? [[String: AnyObject]] else { return nil }
        
        var buffer = [DayForecast]()
        
        for dailyForecast in weeklyForecast {
            if let dailyData = DayForecast(JSON: dailyForecast) {
                buffer.append(dailyData)
            }
        }
        self.weekForecast = buffer
    }
}
