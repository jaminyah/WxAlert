//
//  FetchAlertOperation.swift
//  WxAlert
//
//  Created by macbook on 1/14/19.
//  Copyright © 2019 Jaminya. All rights reserved.
//

import Foundation

final class FetchAlertOperation: Operation {
    override func main() {
        if isCancelled {
            return
        }
        print("FetchAlertOperation")
    }
}
