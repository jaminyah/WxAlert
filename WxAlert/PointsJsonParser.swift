//
//  PointsJsonParser.swift
//  WxAlert
//
//  Created by macbook on 12/4/18.
//  Copyright © 2018 Jaminya. All rights reserved.
//

import Foundation

struct PointsJsonParser: JSONDecodable {
    private (set) var forecastUrl: String = ""
    //private (set) var forecastHourlyUrl: String = ""
    private (set) var forecastZoneUrl: String = ""
    
    init?(JSON: Any) {
        guard let JSON = JSON as?  [String: AnyObject] else { return nil }
        
        if let forecast = JSON["properties"]?["forecast"] as? String { self.forecastUrl = forecast}
       //if let forecastHourly = JSON["properties"]?["forecastHourly"] as? String {self.forecastHourlyUrl = forecastHourly}
        if let forecastZone = JSON["properties"]?["forecastZone"] as? String {self.forecastZoneUrl = forecastZone}
    }
}
