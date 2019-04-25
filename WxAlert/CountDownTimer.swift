//
//  CountDownTimer.swift
//  WxAlert
//
//  Created by macbook on 4/23/19.
//  Copyright © 2019 Jaminya. All rights reserved.
//

import Foundation

class CountDownTimer {
    
    var timer: WallClockTimer
    
    init(timeGap: TimeInterval, city: String, stateID: String) {
        timer = WallClockTimer(interval: timeGap, city: city, stateID: stateID)
    }
    
    func start() {
        timer.eventHandler = UpdateMgr.fetchLatestWeather
    }
}
