//
//  AlertViewModel.swift
//  WxAlert
//
//  Created by macbook on 2/3/19.
//  Copyright © 2019 Jaminya. All rights reserved.
//

import Foundation

class AlertViewModel: CellViewModel {
 
    var alertModels: [AlertModel] = []
    var table: String = "alert_"
    
    override init() {
        super.init()
        self.alertModels = fetchAlerts()
    }
    
    func fetchAlerts() -> [AlertModel] {
        print("fetchAlerts for sqlite.")
        
        var alertData: [AlertModel] = []
        table = table + tableName.lowercased()
        
        let query = "SELECT * FROM \(table);"
        alertData = dbmgr.wxAlerts(from: table, sql: query)
        
        return alertData
    }
}
