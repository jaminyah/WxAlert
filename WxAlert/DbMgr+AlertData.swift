//
//  DbMgr+AlertData.swift
//  WxAlert
//
//  Created by macbook on 12/28/18.
//  Copyright © 2018 Jaminya. All rights reserved.
//

import Foundation

extension DbMgr {
    
    func insert(alerts: [Alert], table: String) -> Void {
        
        var sqlite3_stmt: OpaquePointer? = nil
        var query = String()
        var zSql = String()
        
        var alertId = String()
        var areaDesc = String()
        var effective = String()
        var expires = String()
        var ends = String()
        var severity = String()
        var urgency = String()
        var event = String()
        var senderName = String()
        var headline = String()
        var description = String()
        var instruction = String()
        
        for alert in alerts {
            
            alertId = alert.alertId
            areaDesc = alert.areaDesc
            effective = alert.effective
            expires = alert.expires
            ends = alert.ends
            severity = alert.severity
            urgency = alert.urgency
            event = alert.event
            senderName = alert.senderName
            headline = alert.headline
            description = alert.description
            instruction = alert.instruction
        
             query = "INSERT INTO \(table) (AlertId, AreaDesc, Effective, Expires, Ends, Severity, Urgency, Event, SenderName, Headline, Description, Instruction) VALUES ('\(alertId)', '\(areaDesc)', '\(effective)', '\(expires)', '\(ends)', '\(severity)', '\(urgency)', '\(event)', '\(senderName)', '\(headline)','\(description)', '\(instruction)');"
            
            // Apostrophes such as Washington's create an sqlite error
            query = query.replacingOccurrences(of: "'s", with: "''s")
            zSql = query.replacingOccurrences(of: "'t", with: "''t")
            
            if sqlite3_prepare_v2(sqlite3_db, zSql, -1, &sqlite3_stmt, nil) != SQLITE_OK {
                let errmsg = String(cString: sqlite3_errmsg(sqlite3_db)!)
                print("Error preparing insert, dbmgr_ext: \(errmsg)")
                return
            }
            
            if sqlite3_step(sqlite3_stmt) != SQLITE_DONE {
                let errmsg = String(cString: sqlite3_errmsg(sqlite3_db)!)
                print("error msg: \(errmsg)")
            }
        } // for loop
        
        if  sqlite3_finalize(sqlite3_stmt) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(sqlite3_db))
            print("Error finalizing prepared statement: \(errmsg)")
        }
        sqlite3_stmt = nil
        
    }
    
    func wxAlerts(from: String, sql: String) -> [AlertModel] {
        
        var alertModels: [AlertModel] = []
        var model = AlertModel()
        
        var sqlite3_stmt: OpaquePointer? = nil
        let statement = sql
        
        if sqlite3_prepare_v2(sqlite3_db, statement, -1, &sqlite3_stmt, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(sqlite3_db)!)
            print("Error reading sqlite data: \(errmsg)")
        }
        
        while (sqlite3_step(sqlite3_stmt) == SQLITE_ROW) {
            model.alertId = String(cString:sqlite3_column_text(sqlite3_stmt, 1)!)
            model.areaDesc = String(cString:sqlite3_column_text(sqlite3_stmt, 2)!)
            model.effective = String(cString:sqlite3_column_text(sqlite3_stmt, 3)!)
            model.expires = String(cString:sqlite3_column_text(sqlite3_stmt, 4)!)
            model.ends = String(cString:sqlite3_column_text(sqlite3_stmt, 5)!)
            model.severity = String(cString:sqlite3_column_text(sqlite3_stmt, 6)!)
            model.urgency = String(cString:sqlite3_column_text(sqlite3_stmt, 7)!)
            model.event = String(cString:sqlite3_column_text(sqlite3_stmt, 8)!)
            model.senderName = String(cString:sqlite3_column_text(sqlite3_stmt, 9)!)
            model.headline = String(cString:sqlite3_column_text(sqlite3_stmt, 10)!)
            model.description = String(cString:sqlite3_column_text(sqlite3_stmt, 11)!)
            model.instruction = String(cString:sqlite3_column_text(sqlite3_stmt, 12)!)
            alertModels.append(model)
        }
        
        return alertModels
    }

    
    func createAlert(table: String) -> Void {

        let zSql = "CREATE TABLE IF NOT EXISTS \(table) " +
        " ('Id' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL UNIQUE, 'AlertId' TEXT, 'AreaDesc' TEXT, 'Effective' TEXT, 'Expires' TEXT, 'Ends' TEXT, 'Severity' TEXT, 'Urgency' TEXT, 'Event' TEXT, 'SenderName' TEXT, 'Headline' TEXT, 'Description' TEXT, 'Instruction' TEXT);"
        
        guard sqlite3_exec(sqlite3_db, zSql, nil, nil, nil) == SQLITE_OK else {
            let errmsg = String(cString: sqlite3_errmsg(sqlite3_db)!)
            print("Error creating table: \(errmsg)")
            return
        }
        // DEBUG
        print("Alert table \(table) created.")
    }
}

