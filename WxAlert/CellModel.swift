//
//  CellModel.swift
//  WxAlert
//
//  Created by macbook on 9/19/18.
//  Copyright © 2018 Jaminya. All rights reserved.
//

import Foundation
import UIKit

struct CellModel {
    var day: String = "Mon"
    var wxIcon: UIImage = #imageLiteral(resourceName: "Sun")
    var alertIcon: UIImage = #imageLiteral(resourceName: "alert")
    var rain: String = "0 %"
    var windSpeed: String = "0 mph"
    var windDirection: String = "N"
    var hiTemp: String = "0 F"
    var lowTemp: String = "0 F"
}
