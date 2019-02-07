//
//  AlertCellViewModel.swift
//  WxAlert
//
//  Created by macbook on 2/3/19.
//  Copyright © 2019 Jaminya. All rights reserved.
//

import Foundation

class AlertCellViewModel: CellViewModel {
 
    var alertModels: [AlertModel] = []
    var table: String = "alert_"
    
    override init() {
        super.init()
    }
    
    func fetchAlerts() -> [AlertModel] {
        print("fetchAlerts for sqlite.")
        
       // var query: String
        let alertData: [AlertModel] = []
        
        
        return alertData
    }
}
