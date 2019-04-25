//
//  WeatherOpQueue.swift
//  WxAlert
//
//  Created by macbook on 1/23/19.
//  Copyright © 2019 Jaminya. All rights reserved.
//

import Foundation

class WeatherOpQueue {
    
    var wxUrl = String()
    var name = String()
    var stateID = String()
    
    init(with url: String, city name: String, stateID: String) {
        wxUrl = url
        self.name = name
        self.stateID = stateID
    }
    
    func executeOps() -> Void {
        
        let queue = OperationQueue()
        var operations: [Operation] = []
        
       // var fetchLinkedOp: FetchLinkedOperation
       // let parseLinkedOp = ParseLinkedOperation()
        let fetchWxOp = FetchWxOperation(withUrl: wxUrl)
        let parseWxOp = ParseWxOperation()
        let storeWxOp = StoreWxOperation(withCity: name, state: stateID)
        
        queue.maxConcurrentOperationCount = 1
        
        /*
        let urlString = "http://cdn.jaminya.com/json/links_akq.json"
        //let urlString = "https://api.weather.gov/points/36.9751,-76.3496"
        */

        let adapter = BlockOperation() { [unowned fetchWxOp, unowned parseWxOp] in
            parseWxOp.rawWxData = fetchWxOp.rawWxData
        }
        
        adapter.addDependency(fetchWxOp)
        parseWxOp.addDependency(adapter)
        
        let adapter2 = BlockOperation() { [unowned parseWxOp, unowned storeWxOp] in
            storeWxOp.jsonData = parseWxOp.jsonData
        }
        
        operations = [fetchWxOp, adapter, parseWxOp, adapter2, storeWxOp]
        queue.addOperations(operations, waitUntilFinished: true)
        print("Operations complete.")
    }
    
}
