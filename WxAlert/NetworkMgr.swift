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
    
    func getForecastJSON(url: String) {
        
        let urlString = url
        guard let forecastUrl = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: forecastUrl) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            guard let data = data else { return }
        
            do {
                let jsonData = try JSONSerialization.jsonObject(with: data, options: [])
                if let weatherForecast = WeekForecast(JSON: jsonData) {
                    let forecastDataMgr = ForecastDataMgr(weekForecast: weatherForecast)
                    forecastDataMgr.writeForecast()
                    
                    // print(jsonData)
                }
            } catch let jsonError {
                print(jsonError)
            }
        }.resume() // URLSession
    }
}
