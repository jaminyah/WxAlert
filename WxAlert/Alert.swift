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
    var description: String = "SEVERE THUNDERSTORM WATCH 440 ..."
    
    init?(JSON: Any) {
        
    }
}
