//
//  StringUtils.swift
//  WxAlert
//
//  Created by macbook on 4/26/19.
//  Copyright © 2019 Jaminya. All rights reserved.
//

import Foundation

class StringUtils {
    
    class func concat(name: String, state: String) -> String {
    
        var result = name.replacingOccurrences(of: " ", with: "_")
        result = result + "_" + state
        result = result.lowercased()
        return result
    }
}
