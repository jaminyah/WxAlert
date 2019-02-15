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
    private let city: City
    
    init(withCity city: City) {
        self.city = city
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
        let cityName = city.cityName
        let stateID = city.region.state
        
        if let weatherForecast = WeekForecast(JSON: json) {
            var tableName: String = cityName.replacingOccurrences(of: " ", with: "_") + "_" + stateID
            tableName = tableName.lowercased()
            
            let forecastDataMgr = ForecastDataMgr(forecast: weatherForecast, dbTable: tableName)
            forecastDataMgr.writeForecast()
            print("DbTable name: \(tableName)")
        }
    }
}
