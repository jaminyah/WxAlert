//
//  AlertIcon.swift
//  WxAlert
//
//  Created by macbook on 1/5/19.
//  Copyright © 2019 Jaminya. All rights reserved.
//

import Foundation
import UIKit

class AlertIcon {
    
    init(){}
    
    func fetch(name: String) -> UIImage {
        var icon: UIImage
        
        switch name {
        case "Air Quality Alert":
            icon = UIImage(imageLiteralResourceName: "advis_air_quality")
        case "Air Stagnation Advisory":
            icon = UIImage(imageLiteralResourceName: "advis_air_quality")
        case "Avalanche Watch":
            icon = UIImage(imageLiteralResourceName: "alert_icon")
        case "Avalanche Warning":
            icon = UIImage(imageLiteralResourceName: "alert_icon")
        case "Beach Hazards Statement":
            icon = UIImage(imageLiteralResourceName: "alert_icon")
        case "Coastal Flood Advisory":
            icon = UIImage(imageLiteralResourceName: "alert_icon")
        case "Dense Fog Advisory":
            icon = UIImage(imageLiteralResourceName: "alert_icon")
        case "Flood Advisory":
            icon = UIImage(imageLiteralResourceName: "alert_icon")
        case "Flood Watch":
            icon = UIImage(imageLiteralResourceName: "alert_icon")
        case "Flood Warning":
            icon = UIImage(imageLiteralResourceName: "alert_icon")
        case "High Surf Advisory":
            icon = UIImage(imageLiteralResourceName: "alert_icon")
        case "High Surf Warning":
            icon = UIImage(imageLiteralResourceName: "alert_icon")
        case "High Wind Watch":
            icon = UIImage(imageLiteralResourceName: "alert_icon")
        case "High Wind Warning":
            icon = UIImage(imageLiteralResourceName: "alert_icon")
        case "Hydrologic Outlook":
            icon = UIImage(imageLiteralResourceName: "alert_icon")
        case "Lake Wind Advisory":
            icon = UIImage(imageLiteralResourceName: "alert_icon")
        case "Rip Current Statement":
            icon = UIImage(imageLiteralResourceName: "alert_icon")
        case "Special Weather Statement":
            icon = UIImage(imageLiteralResourceName: "alert_icon")
        case "Wind Advisory":
            icon = UIImage(imageLiteralResourceName: "alert_icon")
        case "Wind Chill Advisory":
            icon = UIImage(imageLiteralResourceName: "alert_icon")
        case "Winter Weather Advisory":
            icon = UIImage(imageLiteralResourceName: "alert_icon")
        case "Winter Storm Warning":
            icon = UIImage(imageLiteralResourceName: "alert_icon")
        case "Winter Storm Watch":
            icon = UIImage(imageLiteralResourceName: "alert_icon")
        default:
            icon = UIImage(imageLiteralResourceName: "alert_icon")
        }
        
        return icon
    }
}
