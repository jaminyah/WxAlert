//
//  WeatherOpQueue.swift
//  WxAlert
//
//  Created by macbook on 1/23/19.
//  Copyright © 2019 Jaminya. All rights reserved.
//

import Foundation

class WeatherOpQueue {
    
    private let city: City
    let queue = OperationQueue()
    var operations: [Operation] = []
    
    init(withCity city: City) {
        self.city = city
    }
    
    func execute() -> Void {
        let lat = city.coordinates.latitude
        let long = city.coordinates.longitude
        let baseUrl = "https://api.weather.gov/points/"
        
        let apiUrl = "\(baseUrl)\(lat),\(long)"
        //print("apiUrl: \(apiUrl)")
        
        guard let pointsUrl = URL(string: apiUrl) else { return }
        
        let fetchWxOp = FetchWxOperation(withURL: pointsUrl)
        let parseWxOp = ParseWxOperation()
        let storeWxOp = StoreWxOperation(withCity: city)
        
        let adapter = BlockOperation() { [unowned fetchWxOp, unowned parseWxOp] in
            parseWxOp.data = fetchWxOp.responseData
        }
        
        let adapter2 = BlockOperation() { [unowned parseWxOp, unowned storeWxOp] in
            storeWxOp.jsonData = parseWxOp.jsonData
        }
        
        adapter.addDependency(fetchWxOp)
        parseWxOp.addDependency(adapter)
        adapter2.addDependency(parseWxOp)
        storeWxOp.addDependency(adapter2)
        
        operations = [fetchWxOp, adapter, parseWxOp, adapter2, storeWxOp]
        queue.addOperations(operations, waitUntilFinished: true)
    }
    
}
