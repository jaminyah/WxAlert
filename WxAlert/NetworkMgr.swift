//
//  NetworkMgr.swift
//  WxAlert
//
//  Created by macbook on 8/28/18.
//  Copyright © 2018 Jaminya. All rights reserved.
//

import Foundation

class NetworkMgr {
    
    var cityObject: City = City()
    private (set) var pointsJson: Any? = nil
    
    init(cityObject: City) {
        self.cityObject = cityObject
    }
    
    init() {}
    
    func getForecastJSON(forecastUrl: URL?) -> Void {
            
        let city = self.cityObject.cityName
        let state = self.cityObject.region.state
    
        guard let url = forecastUrl else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
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
    
    
    func getNWSPointsJSON(completion: @escaping (Any) -> Void) {
        
        // Example: Formulate URL for linked JSON for Wilmington, NC
        // https://api.weather.gov/points/34.2257,-77.944710
        
        // Change - Dec 9, 2018
        // let url = "https://api.weather.gov/gridpoints/MFL/111,49/forecast"
        //let url = "http://cdn.jaminya.com/json/forecast_mia.json"
        
        let lat = self.cityObject.coordinates.latitude
        let long = self.cityObject.coordinates.longitude
        let baseUrl = "https://api.weather.gov/points/"
        let apiUrl = "\(baseUrl)\(lat),\(long)"
        print("apiUrl: \(apiUrl)")
    
        guard let pointsUrl = URL(string: apiUrl) else { return }
        
        URLSession.shared.dataTask(with: pointsUrl) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            guard let data = data else { return }
            
            do {
                let jsonData = try JSONSerialization.jsonObject(with: data, options: [])
                completion(jsonData)
            } catch let jsonError {
                print(jsonError)
            }
        }.resume() // URLSession
    }
    
}
