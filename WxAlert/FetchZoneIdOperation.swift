//
//  FetchZoneIdOperation.swift
//  WxAlert
//
//  Created by macbook on 1/19/19.
//  Copyright © 2019 Jaminya. All rights reserved.
//

import Foundation

class FetchZoneIdOperation: Operation {
    override func main() {
        if isCancelled {
            return
        }
        print("FetchZoneIdOperation")
    }
}
