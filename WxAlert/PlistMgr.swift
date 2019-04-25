//
//  PlistMgr.swift
//  WxAlert
//
//  Created by macbook on 4/10/19.
//  Copyright © 2019 Jaminya. All rights reserved.
//

import Foundation

class PlistMgr {
    
    private class func loadPlist() -> [String:String] {
        var plistData: [String:String] = [:]
        
        let pathFull = Bundle.main.path(forResource: "Links", ofType: "plist")
        if let path = pathFull {
            let pathUrl = URL(fileURLWithPath: path)
            do {
                let dataToDecode = try Data(contentsOf: pathUrl)
                let decoder = PropertyListDecoder()
                plistData = try decoder.decode([String:String].self, from: dataToDecode)
            } catch {
                print(error)
            }
        }
        return plistData
    }
    
    class func addToPlist(key: String, value:String) -> Void {
        
        var plistData = loadPlist()
        let pathFull = Bundle.main.path(forResource: "Links", ofType: "plist")
        if let path = pathFull {
            
            // Append to key:value
            plistData.updateValue(value, forKey: key)
        
            let pathUrl = URL(fileURLWithPath: path)
            // Debug
            // print(pathUrl.absoluteString)
            let encoder = PropertyListEncoder()
            encoder.outputFormat = .xml
            do {
                let dataEncoder = try encoder.encode(plistData)
                try dataEncoder.write(to: pathUrl)
            } catch {
                print(error)
            }
        }
    }
    
    
    class func removeFromPlist(key: String) -> Void {
        
        var plistData = loadPlist()
        let pathFull = Bundle.main.path(forResource: "Links", ofType: "plist")
        if let path = pathFull {
            
            // Delete key:value
            plistData[key] = nil
            
            let pathUrl = URL(fileURLWithPath: path)
            // print(pathUrl.absoluteString)
            let encoder = PropertyListEncoder()
            encoder.outputFormat = .xml
            do {
                let dataEncoder = try encoder.encode(plistData)
                try dataEncoder.write(to: pathUrl)
            } catch {
                print(error)
            }
        }
    }
    
    class func wxURL(city name: String, stateID: String) -> String {
        
        var wxUrl = String()
        var plistData: [String:String] = [:]
        var wxKey: String = name + stateID + "wx"
        wxKey = wxKey.lowercased()
        
        plistData = loadPlist()
        wxUrl = plistData[wxKey] ?? ""
        
        return wxUrl
    }
    
    class func alertURL(city name: String, stateID: String) -> String {
        
        var alUrl = String()
        var plistData: [String:String] = [:]
        var alKey: String = name + stateID + "al"
        alKey = alKey.lowercased()
        
        plistData = loadPlist()
        alUrl = plistData[alKey] ?? ""
        
        return alUrl
    }
    
} // PlistMgr
