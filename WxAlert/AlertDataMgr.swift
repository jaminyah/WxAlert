//
//  AlertDataMgr.swift
//  WxAlert
//
//  Created by macbook on 12/26/18.
//  Copyright © 2018 Jaminya. All rights reserved.
//

import Foundation

class AlertDataMgr {
    
    var alert: AlertList?
    var table: String?
    let dbMgr = DbMgr.sharedInstance
    
    init(alert: AlertList, table: String) {
        self.alert = alert
        self.table = table
    }
    
    func writeAlert() -> Void {
        guard let data = alert?.features else { return }
        guard let tableName = self.table else { return }
        dbMgr.insert(alerts: data, table:tableName)
    }
    
} // AlertDataMgr
