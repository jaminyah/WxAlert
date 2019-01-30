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
        
        let fetchLinkedOp = FetchLinkedOperation(withLink: pointsUrl)
        
        /*
        let parseLinkedOp = ParseLinkedOperation()
        let fetchWxOp = FetchWxOperation()
        let parseWxOp = ParseWxOperation()
        let storeWxOp = StoreWxOperation(withCity: city)
        
        let adapter = BlockOperation() { [unowned fetchLinkedOp, unowned parseLinkedOp] in
            parseLinkedOp.linkedData = fetchLinkedOp.linkedData
        }
        
        let adapter2 = BlockOperation() { [unowned parseLinkedOp, unowned fetchWxOp] in
            fetchWxOp.forecastUrl = parseLinkedOp.forecastUrl
        }
        
        let adapter3 = BlockOperation() { [unowned fetchWxOp, unowned parseWxOp] in
            parseWxOp.rawData = fetchWxOp.rawData
        }
        
        let adapter4 = BlockOperation() { [unowned parseWxOp, unowned storeWxOp] in
            storeWxOp.jsonData = parseWxOp.jsonData
        }
        
        adapter.addDependency(fetchLinkedOp)
        parseLinkedOp.addDependency(adapter)
        adapter2.addDependency(fetchWxOp)
        parseWxOp.addDependency(adapter2)
        adapter3.addDependency(parseWxOp)
        storeWxOp.addDependency(adapter3)
        
        operations = [fetchLinkedOp, adapter, parseLinkedOp, adapter2, fetchWxOp, adapter3, parseWxOp, adapter4, storeWxOp]
        */
        operations = [fetchLinkedOp]
        queue.addOperations(operations, waitUntilFinished: true)
    }
    
}
