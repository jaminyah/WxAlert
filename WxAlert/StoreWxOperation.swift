//
//  StoreWxOperation.swift
//  WxAlert
//
//  Created by macbook on 1/14/19.
//  Copyright © 2019 Jaminya. All rights reserved.
//

import Foundation

final class StoreWxOperation: Operation {
    
    private let json: Any
    private let city: City
    
    init(withJson json: Any, city: City) {
        self.json = json
        self.city = city
    }
    
    override func main() {
        if isCancelled {
            return
        }
        print("StoreWxOperation")
        dbWriteForecast(json: self.json)
    }
    
    private func dbWriteForecast(json: Any) -> Void {
        let cityName = city.cityName
        let stateID = city.region.state
        
        if let weatherForecast = WeekForecast(JSON: json) {
            var tableName: String = cityName.replacingOccurrences(of: " ", with: "_") + "_" + stateID
            tableName = tableName.lowercased()
            
            let forecastDataMgr = ForecastDataMgr(forecast: weatherForecast, table: tableName)
            forecastDataMgr.writeForecast()
            print("DbTable name: \(tableName)")
        }
    }
}
