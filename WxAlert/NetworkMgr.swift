//
//  NetworkMgr.swift
//  WxAlert
//
//  Created by macbook on 8/28/18.
//  Copyright © 2018 Jaminya. All rights reserved.
//

import Foundation

class NetworkMgr {
    
    static let sharedInstance = NetworkMgr()
    private init() {}
    
    func getForecastJSON(city: String, state: String) -> Void {
        
        // TODO - Formulate URL for Wilmington, NC
        // https://api.weather.gov/points/34.2257,-77.944710
        // properties -> forecast
        // properties -> forecastHourly
        
        let urlString = FORECAST_URL2
        guard let forecastUrl = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: forecastUrl) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            guard let data = data else { return }
        
            do {
                let jsonData = try JSONSerialization.jsonObject(with: data, options: [])
                
                if let weatherForecast = WeekForecast(JSON: jsonData) {
                    var tableName: String = city.replacingOccurrences(of: " ", with: "_") + "_" + state
                    tableName = tableName.lowercased()
                    
                    let forecastDataMgr = ForecastDataMgr(forecast: weatherForecast, table: tableName)
                    forecastDataMgr.writeForecast()
                    print("DbTable name: \(tableName)")
               }
            } catch let jsonError {
                print(jsonError)
            }
        }.resume() // URLSession
    }
}
