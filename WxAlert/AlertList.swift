//
//  AlertList.swift
//  WxAlert
//
//  Created by macbook on 12/26/18.
//  Copyright © 2018 Jaminya. All rights reserved.
//

import Foundation

struct AlertList: JSONDecodable {
    
    private (set) var features: [Alert] = []
    
    init?(JSON: Any) {
        guard let JSON = JSON as? [String: AnyObject] else { return nil}
        guard let features = JSON["features"] as? [[String: AnyObject]] else { return nil }
        
        var buffer = [Alert]()
        
        for alert in features {
            if let alertData = Alert(JSON: alert) {
                buffer.append(alertData)
            }
        }
        self.features = buffer
    }
}
