//
//  ParseWxOperation.swift
//  WxAlert
//
//  Created by macbook on 1/14/19.
//  Copyright © 2019 Jaminya. All rights reserved.
//

import Foundation

final class ParseWxOperation: Operation {
    
    var rawData: Data? = nil
    private(set) var jsonData: Any? = nil
    
    override init() {
        super.init()
    }
    
    override func main() {
        if isCancelled {
            return
        }
        print("ParseWxOperation")
        parseJson(input: rawData)
    }
    
    private func parseJson(input: Data?) -> Void {
        guard let data = input else { return }
        do {
            jsonData = try JSONSerialization.jsonObject(with: data, options: [])
            print(jsonData!)
        } catch let jsonError {
            print(jsonError)
        }
    }
}
