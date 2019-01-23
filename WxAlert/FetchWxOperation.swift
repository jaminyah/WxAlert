//
//  FetchWxOperation.swift
//  WxAlert
//
//  Created by macbook on 1/14/19.
//  Copyright © 2019 Jaminya. All rights reserved.
//

import Foundation

final class FetchWxOperation: BaseOperation {
    
    private let forecastUrl: URL
    private(set) var responseData: Data? = nil
    
    init(withURL forecastUrl: URL) {
        self.forecastUrl = forecastUrl
    }
    
    override func main() {
        if isCancelled {
            return
        }
        print("FetchWxOperation")
        getForecastJSON()
    }
    
   private func getForecastJSON() -> Void {
        
        URLSession.shared.dataTask(with: forecastUrl) { (networkData, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                let statusCode = httpResponse.statusCode
                if statusCode != 200 {
                    print("status code: \(statusCode)")
                    
                    // Get local json file with dummy data
                    let dataPath = Bundle.main.url(forResource: "dummy", withExtension: "json")
                    guard let urlPath = dataPath else { return }
                    do {
                        
                        let localData = try Data(contentsOf: urlPath)
                        self.responseData = localData
                        print("Bundle.main: \(localData)")
                        print("urlPath: \(urlPath)")
                    } catch let jsonError {
                        print(jsonError)
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                        NotificationCenter.default.post(name: .show503Alert, object: nil)
                    }
                    
                } else {
                    guard let data = networkData else { return }
                        self.responseData = data
                }
            }
        }.resume() // URLSession
    }
}
