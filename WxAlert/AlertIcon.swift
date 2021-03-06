//
//  AlertIcon.swift
//  WxAlert
//
//  Created by macbook on 1/5/19.
//  Copyright © 2019 Jaminya. All rights reserved.
//

import Foundation
import UIKit

final class AlertIcon {
    
    class func fetch(imageFor name: String?) -> (icon: UIImage?, detailIcon: UIImage?) {
        
        let image: UIImage? = nil, imageDetail: UIImage? = nil
        var alert = (icon: image, detailIcon: imageDetail)
        
        if name == nil { return alert }
        
        switch (name) {
        case "Air Quality Alert":
            alert.icon = UIImage(imageLiteralResourceName: "placeholder_alert_frame")
            alert.detailIcon = UIImage(imageLiteralResourceName: "placeholder_alert_detail")
        case "Air Stagnation Advisory":
            alert.icon = UIImage(imageLiteralResourceName: "placeholder_alert_frame")
            alert.detailIcon = UIImage(imageLiteralResourceName: "placeholder_alert_detail")
        case "Avalanche Watch":
            alert.icon = UIImage(imageLiteralResourceName: "placeholder_alert_frame")
            alert.detailIcon = UIImage(imageLiteralResourceName: "placeholder_alert_detail")
        case "Avalanche Warning":
            alert.icon = UIImage(imageLiteralResourceName: "warn_avalanche")
            alert.detailIcon = UIImage(imageLiteralResourceName: "placeholder_alert_detail")
        case "Beach Hazards Statement":
            alert.icon = UIImage(imageLiteralResourceName: "stmt_beach_haz")
            alert.detailIcon = UIImage(imageLiteralResourceName: "dia_stmt_bchhaz")
        case "Blizzard Advisory":
            alert.icon = UIImage(imageLiteralResourceName: "advisory_blizzard")
            alert.detailIcon = UIImage(imageLiteralResourceName: "placeholder_alert_detail")
        case "Blizzard Warning":
            alert.icon = UIImage(imageLiteralResourceName: "warn_blizz")
            alert.detailIcon = UIImage(imageLiteralResourceName: "dia_warn_blizz")
        case "Coastal Flood Advisory":
            alert.icon = UIImage(imageLiteralResourceName: "placeholder_alert_frame")
            alert.detailIcon = UIImage(imageLiteralResourceName: "placeholder_alert_detail")
        case "Coastal Flood Warning":
            alert.icon = UIImage(imageLiteralResourceName: "placeholder_alert_frame")
            alert.detailIcon = UIImage(imageLiteralResourceName: "placeholder_alert_detail")
        case "Dense Fog Advisory":
            alert.icon = UIImage(imageLiteralResourceName: "advis_densefog")
           alert.detailIcon = UIImage(imageLiteralResourceName: "dia_advis_dfog")
        case "Fire Weather Watch":
            alert.icon = UIImage(imageLiteralResourceName: "watch_fire")
           alert.detailIcon = UIImage(imageLiteralResourceName: "placeholder_alert_detail")
        case "Flash Flood Advisory":
            alert.icon = UIImage(imageLiteralResourceName: "placeholder_alert_frame")
            alert.detailIcon = UIImage(imageLiteralResourceName: "dia_advis_fflood")
        case "Flash Flood Watch":
            alert.icon = UIImage(imageLiteralResourceName: "watch_fflood")
            alert.detailIcon = UIImage(imageLiteralResourceName: "dia_watch_fflood")
        case "Flash Flood Warning":
            alert.icon = UIImage(imageLiteralResourceName: "placeholder_alert_frame")
           alert.detailIcon = UIImage(imageLiteralResourceName: "dia_warn_fflood")
        case "Flood Advisory":
            alert.icon = UIImage(imageLiteralResourceName: "advisory_flood")
           alert.detailIcon = UIImage(imageLiteralResourceName: "dia_advis_flood")
        case "Flood Watch":
            alert.icon = UIImage(imageLiteralResourceName: "watch_flood")
           alert.detailIcon = UIImage(imageLiteralResourceName: "dia_watch_flood")
        case "Flood Warning":
            alert.icon = UIImage(imageLiteralResourceName: "warn_flood")
           alert.detailIcon = UIImage(imageLiteralResourceName: "dia_warn_flood")
        case "Freezing Fog Advisory":
            alert.icon = UIImage(imageLiteralResourceName: "advis_freezefog")
           alert.detailIcon = UIImage(imageLiteralResourceName: "dia_advis_ffog")
        case "Freeze Warning":
            alert.icon = UIImage(imageLiteralResourceName: "warn_freeze")
            alert.detailIcon = UIImage(imageLiteralResourceName: "dia_warn_freeze")
        case "Freeze Watch":
            alert.icon = UIImage(imageLiteralResourceName: "placeholder_alert_frame")
           alert.detailIcon = UIImage(imageLiteralResourceName: "placeholder_alert_detail")
        case "Frost Advisory":
            alert.icon = UIImage(imageLiteralResourceName: "advis_frost")
            alert.detailIcon = UIImage(imageLiteralResourceName: "dia_frost")
        case "Hard Freeze Watch":
            alert.icon = UIImage(imageLiteralResourceName: "placeholder_alert_frame")
           alert.detailIcon = UIImage(imageLiteralResourceName: "placeholder_alert_detail")
        case "Hard Freeze Warning":
            alert.icon = UIImage(imageLiteralResourceName: "placeholder_alert_frame")
           alert.detailIcon = UIImage(imageLiteralResourceName: "placeholder_alert_detail")
        case "High Surf Advisory":
            alert.icon = UIImage(imageLiteralResourceName: "placeholder_alert_frame")
           alert.detailIcon = UIImage(imageLiteralResourceName: "placeholder_alert_detail")
        case "High Surf Warning":
            alert.icon = UIImage(imageLiteralResourceName: "placeholder_alert_frame")
           alert.detailIcon = UIImage(imageLiteralResourceName: "placeholder_alert_detail")
        case "High Wind Watch":
            alert.icon = UIImage(imageLiteralResourceName: "placeholder_alert_frame")
           alert.detailIcon = UIImage(imageLiteralResourceName: "placeholder_alert_detail")
        case "High Wind Warning":
            alert.icon = UIImage(imageLiteralResourceName: "warning_wind")
           alert.detailIcon = UIImage(imageLiteralResourceName: "placeholder_alert_detail")
        case "Hydrologic Outlook":
            alert.icon = UIImage(imageLiteralResourceName: "placeholder_alert_frame")
           alert.detailIcon = UIImage(imageLiteralResourceName: "placeholder_alert_detail")
        case "Ice Storm Warning":
            alert.icon = UIImage(imageLiteralResourceName: "placeholder_alert_frame")
           alert.detailIcon = UIImage(imageLiteralResourceName: "placeholder_alert_detail")
        case "Lake Wind Advisory":
            alert.icon = UIImage(imageLiteralResourceName: "advisory_lakewind")
           alert.detailIcon = UIImage(imageLiteralResourceName: "placeholder_alert_detail")
        case "Lakeshore Flood Watch":
            alert.icon = UIImage(imageLiteralResourceName: "placeholder_alert_frame")
           alert.detailIcon = UIImage(imageLiteralResourceName: "placeholder_alert_detail")
        case "Red Flag Warning":
            alert.icon = UIImage(imageLiteralResourceName: "warning_fire")
           alert.detailIcon = UIImage(imageLiteralResourceName: "placeholder_alert_detail")
        case "Rip Current Statement":
            alert.icon = UIImage(imageLiteralResourceName: "stmt_ripcurrent")
           alert.detailIcon = UIImage(imageLiteralResourceName: "dia_state_ripcurrent")
        case "Rip Current Warning":
            alert.icon = UIImage(imageLiteralResourceName: "warn_ripcurrent")
           alert.detailIcon = UIImage(imageLiteralResourceName: "placeholder_alert_detail")
        case "Severe Thunderstorm Warning":
            alert.icon = UIImage(imageLiteralResourceName: "warn_ststrm")
            alert.detailIcon = UIImage(imageLiteralResourceName: "dia_ststrm")
        case "Severe Thunderstorm Watch":
            alert.icon = UIImage(imageLiteralResourceName: "watch_stsra")
            alert.detailIcon = UIImage(imageLiteralResourceName: "dia_watch_stsra")
        case "Severe Weather Statement":
            alert.icon = UIImage(imageLiteralResourceName: "placeholder_alert_frame")
            alert.detailIcon = UIImage(imageLiteralResourceName: "dia_severe_wx")
        case "Special Weather Statement":
            alert.icon = UIImage(imageLiteralResourceName: "special_stmt")
           alert.detailIcon = UIImage(imageLiteralResourceName: "dia_special_wx")
        case "Tornado Watch":
            alert.icon = UIImage(imageLiteralResourceName: "watch_tornado")
            alert.detailIcon = UIImage(imageLiteralResourceName: "dia_watch_tornado")
        case "Tornado Warning":
            alert.icon = UIImage(imageLiteralResourceName: "warn_tornado")
           alert.detailIcon = UIImage(imageLiteralResourceName: "dia_warn_tornado")
        case "Thunderstorm Watch":
            alert.icon = UIImage(imageLiteralResourceName: "placeholder_alert_frame")
           alert.detailIcon = UIImage(imageLiteralResourceName: "placeholder_alert_detail")
        case "Thunderstorm Warning":
            alert.icon = UIImage(imageLiteralResourceName: "placeholder_alert_frame")
           alert.detailIcon = UIImage(imageLiteralResourceName: "placeholder_alert_detail")
        case "Wind Advisory":
            alert.icon = UIImage(imageLiteralResourceName: "advisory_wind")
           alert.detailIcon = UIImage(imageLiteralResourceName: "placeholder_alert_detail")
        case "Wind Chill Advisory":
            alert.icon = UIImage(imageLiteralResourceName: "advisory_windchill")
           alert.detailIcon = UIImage(imageLiteralResourceName: "placeholder_alert_detail")
        case "Wind Chill Warning":
            alert.icon = UIImage(imageLiteralResourceName: "warn_windchill")
           alert.detailIcon = UIImage(imageLiteralResourceName: "placeholder_alert_detail")
        case "Winter Weather Advisory":
            alert.icon = UIImage(imageLiteralResourceName: "advisory_winter")
           alert.detailIcon = UIImage(imageLiteralResourceName: "advis_winter_wx")
        case "Winter Storm Warning":
            alert.icon = UIImage(imageLiteralResourceName: "warn_winter")
           alert.detailIcon = UIImage(imageLiteralResourceName: "dia_warn_winter")
        case "Winter Storm Watch":
            alert.icon = UIImage(imageLiteralResourceName: "watch_winter")
           alert.detailIcon = UIImage(imageLiteralResourceName: "placeholder_alert_detail")
        default:
            alert.icon = UIImage(imageLiteralResourceName: "placeholder_alert_frame")
           alert.detailIcon = UIImage(imageLiteralResourceName: "placeholder_alert_detail")
        }
        return alert
    }
}
