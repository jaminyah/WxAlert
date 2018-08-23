//
//  SelectedCity.swift
//  WxAlert
//
//  Created by macbook on 8/10/18.
//  Copyright © 2018 Jaminya. All rights reserved.
//

import Foundation

struct SelectedCity {
    var name: String = "Dallas"
    var state: String = "TX"
    var arrayIndex: Int = 0            // First row in app setting tableView section 3
    var wxRefreshRate = 4              // Refresh Wx UI every 4 hours
    var timeFrame: TimeFrame = TimeFrame.Day
}

enum TimeFrame: String {
    case Day = "Day"
    case DayNight = "Day+Night"
    case Night = "Night"
}
