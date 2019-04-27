//
//  Definitions.swift
//  WxAlert
//
//  Created by macbook on 3/21/18.
//  Copyright © 2018 Jaminya. All rights reserved.
//

import Foundation

extension NSNotification.Name {
    static let refreshCityNames = NSNotification.Name("refreshCityNames")
    static let show503Alert = NSNotification.Name("show503Alert")
    static let didUpdateWeather = NSNotification.Name("didUpdateWeather")
    static let didUpdateAlert = NSNotification.Name("didUpdateAlert")
}
