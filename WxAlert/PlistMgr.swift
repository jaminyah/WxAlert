//
//  PlistMgr.swift
//  WxAlert
//
//  Created by macbook on 4/10/19.
//  Copyright © 2019 Jaminya. All rights reserved.
//

import Foundation

class PlistMgr {
    
    class func read(fileName: String) -> RemoteUrls {
        
        var remoteUrls = RemoteUrls()
        
        if let path = Bundle.main.path(forResource: fileName, ofType: "plist"),
            let xml = FileManager.default.contents(atPath: path),
            let plistUrls = try? PropertyListDecoder().decode(RemoteUrls.self, from: xml) {
            remoteUrls = plistUrls
        }
        return remoteUrls
    }
    
    class func write(plist: String, remoteUrls: RemoteUrls) -> Void {
        let encoder = PropertyListEncoder()
        encoder.outputFormat = .xml
        
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(plist)
        do {
            let data = try encoder.encode(remoteUrls)
            try data.write(to: path)
        } catch {
            print("Encoder error")
        }
    }
    
    class func delete(element: [String: String]) -> Void {
        
    }
}
