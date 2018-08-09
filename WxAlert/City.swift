//
//  City.swift
//  WxAlert
//
//  Created by macbook on 3/20/18.
//  Copyright © 2018 Jaminya. All rights reserved.
//

import Foundation


struct City {
    
    let elements = ["Fire danger", "Fog", "Flood", "Freeze", "Hail", "Heat", "High Winds", "Ice", "Lightning", "Rain", "Rip Current", "Sleet", "Snow", "Thunderstorm", "Tornado"]
    var cityName = "Dallas"
    var region =  Region()
    var coordinates = Coordinates()
    var notificationList = [Notification]()
    
    init() {}
}

struct CityState {
    var cityName = "Dallas"
    var region = Region()
}

struct Region {
    var state = "TX"
}

struct Coordinates {
    var latitude = 32.7763
    var longitude = -96.7969
}

struct Notification {
    var name = "Rain"
    var enabled = false
}

struct SelectedCity {
    var name: String = "Dallas"
    var arrayIndex: Int = 0
    var timeFrame: TimeFrame = TimeFrame.Day
}

enum TimeFrame: String {
    case Day = "Day"
    case DayNight = "Day+Night"
    case Night = "Night"
}

extension City {
    
    init(name: String, state: String, coordinates: Coordinates) {
        cityName = name
        region = Region(state: state)
        self.coordinates = coordinates
        var notification = Notification()
        
        for (_, item) in elements.enumerated() {
            notification = Notification (name: item, enabled: false)
            notificationList.append(notification)
        }
    }
}
