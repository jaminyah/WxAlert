//
//  ParseWxOperation.swift
//  WxAlert
//
//  Created by macbook on 1/14/19.
//  Copyright © 2019 Jaminya. All rights reserved.
//

import Foundation

final class ParseWxOperation: Operation {
    
    var data: Data?
    private(set) var jsonData: Any? = nil
    
    /*
    init(withData data: Data) {
        self.data = data
    }*/
    override init() {
        super.init()
    }
    
    override func main() {
        if isCancelled {
            return
        }
        print("ParseWxOperation")
        parseJson()
    }
    
    private func parseJson() -> Void {
        guard let data = data else { return }
        do {
            jsonData = try JSONSerialization.jsonObject(with: data, options: [])
            print(jsonData!)
        } catch let jsonError {
            print(jsonError)
        }
    }
}
