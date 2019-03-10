//
//  Alert.swift
//  WxAlert
//
//  Created by macbook on 12/26/18.
//  Copyright © 2018 Jaminya. All rights reserved.
//

import Foundation

struct Alert: JSONDecodable {
    
    var alertId = String()                          // "NWS-IDP-PROD-3270190-2862070"
    var areaDesc = String()                         // "Biscayne Bay"
    var effective = String()                        // "2018-12-20T16:37:00-05:00"
    var expires = String()                          // "2018-12-20T21:00:0000-05:00"
    var ends = String()                             // "2018-12-20T21:00:0000-05:00"
    var severity = String()                         // "Severe"
    var urgency = String()                          // "Immediate"
    var event = String()                            // "Severe Thunderstorm Watch"
    var senderName = String()                       // "NWS Mobile AL"
    var headline = String()                         // "Severe Thunderstorm Watch issued December 20 ..."
    var description = String()                      // "SEVERE THUNDERSTORM WATCH 440 ..."
    var instruction = String()                      // "PRECAUTIONARY/PREPAREDNESS ACTIONS..."
    
    init?(JSON: Any) {
        
        guard let JSON = JSON as? [String: AnyObject] else { return nil }
        if let id = JSON["properties"]?["id"] as? String { self.alertId = id } else {self.alertId = "NWS-IDP-PROD-XXXXXXX-XXXXXXX"}
        if let areaDesc = JSON["properties"]?["areaDesc"] as? String { self.areaDesc = areaDesc } else { self.areaDesc = ""}
        if let effective = JSON["properties"]?["effective"] as? String { self.effective = effective } else { self.effective = ""}
        if let expires = JSON["properties"]?["expires"] as? String { self.expires = expires } else { self.expires = ""}
        if let ends = JSON["properties"]?["ends"] as? String { self.ends = ends } else { self.ends = ""}
        if let severity = JSON["properties"]?["severity"] as? String { self.severity = severity } else { self.severity = ""}
        if let urgency = JSON["properties"]?["urgency"] as? String { self.urgency = urgency } else { self.urgency = ""}
        if let event = JSON["properties"]?["event"] as? String { self.event = event } else { self.event = ""}
        if let areaDesc = JSON["properties"]?["areaDesc"] as? String { self.areaDesc = areaDesc } else { self.areaDesc = ""}
        if let senderName = JSON["properties"]?["senderName"] as? String { self.senderName = senderName } else { self.senderName = ""}
        if let headline = JSON["properties"]?["headline"] as? String { self.headline = headline } else { self.headline = ""}
        if let description = JSON["properties"]?["description"] as? String { self.description = description } else { self.description = ""}
        if let instruction = JSON["properties"]?["instruction"] as? String { self.instruction = instruction } else { self.instruction = ""}
    }
}
