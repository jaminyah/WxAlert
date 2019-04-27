//
//  StoreWxOperation.swift
//  WxAlert
//
//  Created by macbook on 1/14/19.
//  Copyright © 2019 Jaminya. All rights reserved.
//

import Foundation

final class StoreWxOperation: Operation {
    
    var jsonData: Any? = nil
    private let cityName: String
    private let state: String
    
    init(withCity cityName: String, state: String) {
        self.cityName = cityName
        self.state = state
    }
    
    override func main() {
        if isCancelled {
            return
        }
        print("StoreWxOperation")
        guard let jsonData = jsonData else { return }
        dbWriteForecast(json: jsonData)
    }
    
    private func dbWriteForecast(json: Any) -> Void {
        let name = cityName
        let stateID = state
        
        if let weatherForecast = WeekForecast(JSON: json) {
            var tableName: String = name.replacingOccurrences(of: " ", with: "_") + "_" + stateID
            tableName = tableName.lowercased()
            
            let forecastDataMgr = ForecastDataMgr(forecast: weatherForecast, cityName: name, stateCode:stateID)
            forecastDataMgr.writeForecast()
            print("DbTable name: \(tableName)")
        }
    }
}
