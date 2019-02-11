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
    var alertId: String = "NWS-IDP-PROD-3270190-2862070"
    var type: String = "wx:Alert"
    var areaDesc: String = "Biscayne Bay"
    var sent: String = "2018-12-20T16:37:00-05:00"
    var effective: String = "2018-12-20T16:37:00-05:00"
    var expires: String = "2018-12-20T21:00:0000-05:00"
    var ends: String = "2018-12-20T21:00:0000-05:00"
    var status: String = "Actual"
    var messageType: String = "Initial"
    var category: String = "Met"
    var severity: String = "Severe"
    var certainty: String = "Observed"
    var urgency: String = "Immediate"
    var event: String = "Severe Thunderstorm Watch"
    var sender: String = "w-nws.webmaster@noaa.gov"
    var senderName: String = "NWS Mobile AL"
    var headline: String = "Severe Thunderstorm Watch issued December 20 ..."
    var description: String = "SEVERE THUNDERSTORM WATCH 440 ..."
    var instruction: String = "PRECAUTIONARY/PREPAREDNESS ACTIONS..."
    var response: String = "Avoid"
    var icon: UIImage = UIImage(imageLiteralResourceName: "alert_icon")
}
