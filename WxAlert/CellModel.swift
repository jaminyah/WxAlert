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
    var date: String = ""
    var dayNightIcon: UIImage = UIImage(imageLiteralResourceName: "sun_icon")
    var wxIcon: UIImage = UIImage(imageLiteralResourceName: "skc")
    var wxText: String = "Fair/clear"
    var wxChance: String? = nil
    //var alertIcons: [UIImage]? = []
    var alertIcon: UIImage? = nil
    var alertLbl: String? = nil
    var windSpeed: String = "0 mph"
    var windDirection: String? = "N"
    var windIcon: UIImage? = #imageLiteral(resourceName: "wind_east")
    var hiTemp: String? = nil
    var lowTemp: String? = nil
    var shortForecast: String = ""
    var detailedForecast: String = ""
}
