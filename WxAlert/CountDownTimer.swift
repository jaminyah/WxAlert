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
        print("timer initialized")
    }
    
    func start() {
        timer.eventHandler = fetchLatestWeather
        //timer.eventHandler = showTimer
        timer.resume()
    }
    
    fileprivate func showTimer(city: String, state: String ) -> Void {
        let time = Date()
        print("time: \(time)")
    }
    
    func fetchLatestWeather(cityName: String, stateUS: String) -> Void {
        print("fetchLatestWeather")
        let time = Date()
        print("time: \(time)")
        
        let weatherUrl = PlistMgr.wxURL(city: cityName, stateID: stateUS)
        let weatherOpQ = WeatherOpQueue(with: weatherUrl, city: cityName, stateID: stateUS)
        weatherOpQ.executeOps()
    }
}
