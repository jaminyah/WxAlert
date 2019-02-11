//
//  Alert.swift
//  WxAlert
//
//  Created by macbook on 12/26/18.
//  Copyright © 2018 Jaminya. All rights reserved.
//

import Foundation
import UIKit

struct Alert: JSONDecodable {
    
    var alertId: String = "NWS-IDP-PROD-3270190-2862070"
    var type: String = "wx:Alert"
    var areaDesc: String = "Biscayne Bay"
    var sent: String = "2018-12-20T16:37:00-05:00"
    var effective: String = "2018-12-20T16:37:00-05:00"
    var expires: String = "2018-12-20T21:00:0000-05:00"
    var ends: String = "2018-12-20T21:00:0000-05:00"
    var status: String = "Actual"
    var messageType: String = "Update"
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
    
    init?(JSON: Any) {
        
        guard let JSON = JSON as? [String: AnyObject] else { return nil }
        if let id = JSON["properites"]?["id"] as? String { self.alertId = id } else {self.alertId = "NWS-IDP-PROD-XXXXXXX-XXXXXXX"}
        if let type = JSON["properties"]?["@type"] as? String { self.type = type } else { self.type = "wx:Alert"}
        if let areaDesc = JSON["properties"]?["areaDesc"] as? String { self.areaDesc = areaDesc } else { self.areaDesc = ""}
        if let sent = JSON["properties"]?["sent"] as? String { self.sent = sent } else { self.sent = ""}
        if let effective = JSON["properties"]?["effective"] as? String { self.effective = effective } else { self.effective = ""}
        if let expires = JSON["properties"]?["expires"] as? String { self.expires = expires } else { self.expires = ""}
        if let ends = JSON["properties"]?["ends"] as? String { self.ends = ends } else { self.ends = ""}
        if let status = JSON["properties"]?["status"] as? String { self.status = status } else { self.status = ""}
        if let msgType = JSON["properties"]?["messageType"] as? String { self.messageType = msgType } else { self.messageType = "NoType"}
        if let severity = JSON["properties"]?["severity"] as? String { self.severity = severity } else { self.severity = ""}
        if let certainty = JSON["properties"]?["certainty"] as? String { self.certainty = certainty } else { self.certainty = ""}
        if let urgency = JSON["properties"]?["urgency"] as? String { self.urgency = urgency } else { self.urgency = ""}
        if let event = JSON["properties"]?["event"] as? String { self.event = event } else { self.event = ""}
        if let areaDesc = JSON["properties"]?["areaDesc"] as? String { self.areaDesc = areaDesc } else { self.areaDesc = ""}
        if let sender = JSON["properties"]?["sender"] as? String { self.sender = sender } else { self.sender = ""}
        if let senderName = JSON["properties"]?["senderName"] as? String { self.senderName = senderName } else { self.senderName = ""}
        if let headline = JSON["properties"]?["headline"] as? String { self.headline = headline } else { self.headline = ""}
        if let description = JSON["properties"]?["description"] as? String { self.description = description } else { self.description = ""}
        if let instruction = JSON["properties"]?["instruction"] as? String { self.instruction = instruction } else { self.instruction = ""}
        if let response = JSON["properties"]?["response"] as? String { self.response = response } else { self.response = ""}
        
    }
}
