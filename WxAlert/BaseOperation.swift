//
//  BaseOperation.swift
//  WxAlert
//
//  Created by macbook on 1/20/19.
//  Copyright © 2019 Jaminya. All rights reserved.
//

import Foundation

class BaseOperation: Operation {
    
    private var _executing: Bool
    override var isExecuting: Bool {
        get { return _executing }
        set {
            willChangeValue(forKey: "isExecuting")
            _executing = newValue
            didChangeValue(forKey: "isExecuting")
        }
    }
    
    private var _finished: Bool
    override var isFinished: Bool {
        get { return _finished }
        set {
            willChangeValue(forKey: "isFinished")
            _finished = newValue
            didChangeValue(forKey: "isFinished")
        }
    }
    
    override init() {
        _executing = false
        _finished = false
        super.init()
    }
    
    func completeOperation() {
        isExecuting = false
        isFinished = true
    }
}
