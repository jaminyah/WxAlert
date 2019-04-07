//
//  FetchWxOperation.swift
//  WxAlert
//
//  Created by macbook on 1/14/19.
//  Copyright © 2019 Jaminya. All rights reserved.
//

import Foundation

final class FetchWxOperation: BaseOperation {
    
    var forecastUrl: URL? = nil
    private(set) var rawData: Data? = nil
   
    override func main() {
        if isCancelled {
            completeOperation()
            return
        }
        print("FetchWxOperation")
        getForecastJSON(inputUrl: forecastUrl)
    }
    
    private func getForecastJSON(inputUrl: URL?) -> Void {
    
        guard let url = inputUrl else { return }
        URLSession.shared.dataTask(with: url) { (networkData, response, error) in
            
            if self.isCancelled {
                self.completeOperation()
                return
            } else if error != nil {
                print(error!.localizedDescription)
                self.completeOperation()
                return
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
                        self.rawData = localData
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
                        self.rawData = data
                }
                self.completeOperation()
            }
        }.resume() // URLSession
    }
}
