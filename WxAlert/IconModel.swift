//
//  IconComponent.swift
//  WxAlert
//
//  Created by macbook on 9/30/18.
//  Copyright © 2018 Jaminya. All rights reserved.
//

import Foundation
import UIKit

struct IconModel {
    var location: Location
    var timePeriod: TimePeriod
    var sky: Meteorology
    var rain: Bool
    var rainChance: String?
}

enum Location {
    case land, sea
}

enum TimePeriod {
    case day, night
}
