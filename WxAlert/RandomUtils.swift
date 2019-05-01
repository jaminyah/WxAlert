//
//  RandomUtils.swift
//  WxAlert
//
//  Created by macbook on 5/1/19.
//  Copyright © 2019 Jaminya. All rights reserved.
//
// Reference: https://stackoverflow.com/questions/3420581/how-to-select-range...

import Foundation

class RandomUtils {
    
    class func numGen(inRange lower: Int, to upper: Int) -> Int {
        
        let number = arc4random_uniform(UInt32(upper - (lower + 1))) + UInt32(lower)
        return Int(number)
    }
}
