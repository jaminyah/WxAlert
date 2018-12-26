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
        <#code#>
    }
}
