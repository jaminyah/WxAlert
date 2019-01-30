//
//  ParseLinkOperation.swift
//  WxAlert
//
//  Created by macbook on 1/25/19.
//  Copyright © 2019 Jaminya. All rights reserved.
//

import Foundation

final class ParseLinkedOperation: BaseOperation {
    
    private(set) var forecastUrl: URL? = nil
    var linkedData: Data? = nil
    
    override init() {
        super.init()
    }
    
    override func main() {
        var jsonData: Any? = nil
        
        if isCancelled {
            return
        }
        print("ParseLinkedOperation")
        jsonData = decodeLinkedJson(data: linkedData)
        guard let data = jsonData else { return }
        forecastUrl = parseLinkedJson(json: data)
    }
    
    private func decodeLinkedJson(data: Data?) -> Any? {
        var json: Any? = nil
        guard let data = linkedData else { return nil }
        
        do {
            json = try JSONSerialization.jsonObject(with: data, options: [])
            print(json!)
        } catch let jsonError {
            print(jsonError)
        }
        return json
    }
    
    private func parseLinkedJson(json: Any) -> URL? {
        var forecastUrl: URL? = nil
        
        if let jsonParser = PointsJsonParser(JSON: json) {
            let urlString = jsonParser.forecastUrl
            forecastUrl = URL(string: urlString)
            
        }
        return forecastUrl
    }
}
