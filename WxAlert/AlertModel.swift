//
//  AlertModel.swift
//  WxAlert
//
//  Created by macbook on 2/3/19.
//  Copyright © 2019 Jaminya. All rights reserved.
//

import Foundation
import UIKit

struct AlertModel {
    var alertId = String()          // "NWS-IDP-PROD-3270190-2862070"
    var areaDesc = String()         // "Biscayne Bay"
    var effective = String()        // "2018-12-20T16:37:00-05:00"
    var expires = String()          // "2018-12-20T21:00:0000-05:00"
    var ends = String()             // "2018-12-20T21:00:0000-05:00"
    var severity = String()         // "Severe"
    var urgency = String()          // "Immediate"
    var event: String = String()    // "Severe Thunderstorm Watch"
    var senderName = String()       // "NWS Mobile AL"
    var headline = String()         // "Severe Thunderstorm Watch ..."
    var description = String()      // "SEVERE THUNDERSTORM WATCH 440 ..."
    var instruction = String()      // "PRECAUTIONARY/PREPAREDNESS ACTIONS..."
    var icon: UIImage = UIImage(imageLiteralResourceName: "alert_icon")
}
