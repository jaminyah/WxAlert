//
//  WallClockTimer.swift
//  WxAlert
//
//  Created by macbook on 4/23/19.
//  Copyright © 2019 Jaminya. All rights reserved.
//

import Foundation

class WallClockTimer {
    
    let interval: TimeInterval
    var eventHandler: ((String, String) -> Void)?
    var city: String
    var stateID: String
    
    init(interval: TimeInterval, city: String, stateID: String) {
        self.interval = interval
        self.city = city
        self.stateID = stateID
    }
    
    private lazy var timer: DispatchSourceTimer = {
        let countdown = DispatchSource.makeTimerSource()
        countdown.schedule(wallDeadline: .now() + self.interval, repeating: .never, leeway: .seconds(60))
        countdown.setEventHandler(handler: {[weak self] in
            self?.eventHandler?(self?.city ?? "dallas", self?.stateID ?? "tx")
        })
        return countdown
    }()
    
    private enum State {
        case suspended
        case resumed
    }
    
    private var state: State = .suspended
    
    func resume() -> Void {
        switch state {
        case  .resumed:
            return
        default:
            state = .resumed
            timer.resume()
        }
    }
    
    func suspend() -> Void {
        switch state {
        case .suspended:
            return
        default:
            state = .suspended
            timer.suspend()
        }
    }
    
    deinit {
        timer.setEventHandler{}
        timer.cancel()
        resume()
        eventHandler = nil
    }
}
