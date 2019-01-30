//
//  FetchLinkedOperation.swift
//  WxAlert
//
//  Created by macbook on 1/25/19.
//  Copyright © 2019 Jaminya. All rights reserved.
//

import Foundation

final class FetchLinkedOperation: BaseOperation {
    
    private(set) var linkedData: Data? = nil
    private let linkedUrl: URL
    
    init(withLink linkedUrl: URL) {
        self.linkedUrl = linkedUrl
    }
    
    override func main() {
        if isCancelled {
            return
        }
        print("FetchLinkOperation")
        getLinkedJSON(url: linkedUrl)
    }
    
    func getLinkedJSON(url: URL) -> Void {
        print("getLinkJSON")
        
        URLSession.shared.dataTask(with: url) { (networkData, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                let statusCode = httpResponse.statusCode
                if statusCode != 200 {
                    print("status code: \(statusCode)")
                    NotificationCenter.default.post(name: .show503Alert, object: nil)
                } else {
                    guard let data = networkData else { return }
                    self.linkedData = data
                }
            }
        }.resume() // URLSession
    }
}
