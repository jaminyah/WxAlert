//
//  Timer.swift
//  WxAlert
//
//  Created by macbook on 4/23/19.
//  Copyright © 2019 Jaminya. All rights reserved.
//

import Foundation

class Timer {
    
    var timer: BackgroundTimer
    
    init(timeGap: TimeInterval) {
        timer = BackgroundTimer(interval: timeGap)
    }
    
    func start() {
        timer.eventHandler = showTimer
        timer.resume()
    }
    
    fileprivate func showTimer() -> Void {
        let time = Date()
        print("time: \(time)")
    }
}
