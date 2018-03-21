//
//  City.swift
//  WxAlert
//
//  Created by macbook on 3/20/18.
//  Copyright © 2018 Jaminya. All rights reserved.
//

import Foundation

/*
 struct City {
    var name = String()
    var region = String()
    var latitude: Double = 0.0
    var longitude: Double = 0.0
}
*/

struct City {
    
    let elements = ["Fog", "Flood", "Freeze", "Hail", "High Winds", "Ice", "Rain", "Sleet", "Snow", "Thunderstorm", "Tornado"]
    var cityName = "Dallas"
    var region =  Region()
    var coordinates = Coordinates()
    var notificationList = [Notification]()
    
    init() {}
}

struct Region {
    var state = "Texas"
}

struct Coordinates {
    var latitude = 32.7763
    var longitude = -96.7969
}

struct Notification {
    var name = "Rain"
    var enabled = false
}

extension City {
    
    init(name: String, state: String, coordinates: Coordinates) {
        cityName = name
        region.state = state
        self.coordinates = coordinates
        var notification = Notification()
        
        for (_, item) in elements.enumerated() {
            notification = Notification (name: item, enabled: false)
            notificationList.append(notification)
        }
    }
}