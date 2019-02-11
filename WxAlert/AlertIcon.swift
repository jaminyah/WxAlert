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
    
    init() {}
    
    func fetch(imageFor name: String) -> UIImage {
        var icon: UIImage
        
        switch (name) {
        case "Air Quality Alert":
            icon = UIImage(imageLiteralResourceName: "flood_alert")
        case "Air Stagnation Advisory":
            icon = UIImage(imageLiteralResourceName: "flood_alert")
        case "Avalanche Watch":
            icon = UIImage(imageLiteralResourceName: "flood_alert")
        case "Avalanche Warning":
            icon = UIImage(imageLiteralResourceName: "flood_alert")
        case "Beach Hazards Statement":
            icon = UIImage(imageLiteralResourceName: "flood_alert")
        case "Blizzard Warning":
            icon = UIImage(imageLiteralResourceName: "flood_alert")
        case "Coastal Flood Advisory":
            icon = UIImage(imageLiteralResourceName: "flood_alert")
        case "Dense Fog Advisory":
            icon = UIImage(imageLiteralResourceName: "flood_alert")
        case "Flood Advisory":
            icon = UIImage(imageLiteralResourceName: "flood_alert")
        case "Flood Watch":
            icon = UIImage(imageLiteralResourceName: "flood_alert")
        case "Flood Warning":
            icon = UIImage(imageLiteralResourceName: "flood_alert")
        case "Freeze Warning":
            icon = UIImage(imageLiteralResourceName: "flood_alert")
        case "Freeze Watch":
            icon = UIImage(imageLiteralResourceName: "flood_alert")
        case "Hard Freeze Watch":
            icon = UIImage(imageLiteralResourceName: "flood_alert")
        case "Hard Freeze Warning":
            icon = UIImage(imageLiteralResourceName: "flood_alert")
        case "High Surf Advisory":
            icon = UIImage(imageLiteralResourceName: "flood_alert")
        case "High Surf Warning":
            icon = UIImage(imageLiteralResourceName: "flood_alert")
        case "High Wind Watch":
            icon = UIImage(imageLiteralResourceName: "flood_alert")
        case "High Wind Warning":
            icon = UIImage(imageLiteralResourceName: "flood_alert")
        case "Hydrologic Outlook":
            icon = UIImage(imageLiteralResourceName: "flood_alert")
        case "Lake Wind Advisory":
            icon = UIImage(imageLiteralResourceName: "flood_alert")
        case "Red Flag Warning":
            icon = UIImage(imageLiteralResourceName: "fire_alert")
        case "Rip Current Statement":
            icon = UIImage(imageLiteralResourceName: "flood_alert")
        case "Special Weather Statement":
            icon = UIImage(imageLiteralResourceName: "flood_alert")
        case "Thunderstorm Watch":
            icon = UIImage(imageLiteralResourceName: "flood_alert")
        case "Thunderstorm Warning":
            icon = UIImage(imageLiteralResourceName: "flood_alert")
        case "Wind Advisory":
            icon = UIImage(imageLiteralResourceName: "flood_alert")
        case "Wind Chill Advisory":
            icon = UIImage(imageLiteralResourceName: "flood_alert")
        case "Wind Chill Watch":
            icon = UIImage(imageLiteralResourceName: "flood_alert")
        case "Winter Weather Advisory":
            icon = UIImage(imageLiteralResourceName: "flood_alert")
        case "Winter Storm Warning":
            icon = UIImage(imageLiteralResourceName: "flood_alert")
        case "Winter Storm Watch":
            icon = UIImage(imageLiteralResourceName: "flood_alert")
        default:
            icon = UIImage(imageLiteralResourceName: "flood_alert")
        }
        
        return icon
    }
}
