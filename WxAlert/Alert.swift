//
//  Alert.swift
//  WxAlert
//
//  Created by macbook on 12/26/18.
//  Copyright © 2018 Jaminya. All rights reserved.
//

import Foundation

struct Alert: JSONDecodable {
    var id: String = "NWS-IDP-PROD-3270190-2862070"
    var type: String = "wx:Alert"
    var areaDesc: String = "Biscayne Bay"
    var effective: String = "2018-12-20T16:37:00-05:00"
    var expires: String = "2018-12-20T21:00:0000-05:00"
    var severity: String = "Severe"
    var event: String = "Severe Thunderstorm Watch"
    var headline: String = "Severe Thunderstorm Watch issued December 20 ..."
    var desc: String = "SEVERE THUNDERSTORM WATCH 440 ..."
    
    init?(JSON: Any) {
        
        guard let JSON = JSON as? [String: AnyObject] else { return nil }
        if let id = JSON["properites"]?["id"] as? String { self.id = id } else {self.id = "NWS-IDP-PROD-XXXXXXX-XXXXXXX"}
        if let type = JSON["properties"]?["@type"] as? String { self.type = type } else { self.type = "wx:Alert"}
        if let areaDesc = JSON["properties"]?["areaDesc"] as? String { self.areaDesc = areaDesc } else { self.areaDesc = ""}
        if let effective = JSON["properties"]?["effective"] as? String { self.effective = effective } else { self.effective = ""}
        if let expires = JSON["properties"]?["expires"] as? String { self.expires = expires } else { self.expires = ""}
        if let severity = JSON["properties"]?["severity"] as? String { self.severity = severity } else { self.severity = ""}
        if let event = JSON["properties"]?["event"] as? String { self.event = event } else { self.event = ""}
        if let headline = JSON["properties"]?["headline"] as? String { self.headline = headline } else { self.headline = ""}
        if let desc = JSON["properties"]?["description"] as? String { self.desc = desc } else { self.desc = ""}
    }
}
