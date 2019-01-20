//
//  ParseZoneIdOperation.swift
//  WxAlert
//
//  Created by macbook on 1/19/19.
//  Copyright © 2019 Jaminya. All rights reserved.
//

import Foundation

class ParseZoneIdOperation: Operation {
    override func main() {
        if isCancelled {
            return
        }
        print("ParseZoneIdOperation")
    }
}
