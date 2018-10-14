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
    var dayNightIcon: UIImage = #imageLiteral(resourceName: "sun_icon")
    var wxIcon: UIImage = #imageLiteral(resourceName: "Sun")
    var wxText: String = "Fair/clear"
    var wxChance: String? = "0 %"
    var alertIcon: UIImage? = #imageLiteral(resourceName: "alert")
    var windSpeed: String = "0 mph"
    var windDirection: String? = "N"
    var windIcon: UIImage? = #imageLiteral(resourceName: "wind_east")
    var hiTemp: String? = nil
    var lowTemp: String? = nil
    var shortForecast: String = ""
    var detailedForecast: String = ""

}
