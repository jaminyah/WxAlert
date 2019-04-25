//
//  BackgroundTimer.swift
//  WxAlert
//
//  Created by macbook on 4/23/19.
//  Copyright © 2019 Jaminya. All rights reserved.
//

import Foundation

class BackgroundTimer {
    
    let interval: TimeInterval
    var eventHandler: (() -> Void)?
    
    init(interval: TimeInterval) {
        self.interval = interval
    }
    
    private lazy var timer: DispatchSourceTimer = {
        let countdown = DispatchSource.makeTimerSource()
        countdown.schedule(wallDeadline: .now() + self.interval, repeating: self.interval, leeway: .seconds(60))
        countdown.setEventHandler(handler: {[weak self] in
            self?.eventHandler?()
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
