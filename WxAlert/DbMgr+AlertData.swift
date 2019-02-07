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
        // TODO: insert alerts into db table
        var sqlite3_stmt: OpaquePointer? = nil
        
        for alert in alerts {
            let alertId = alert.id
            let type = alert.type
            let areaDesc = alert.areaDesc
            let effective = alert.effective
            let expires = alert.expires
            let severity = alert.severity
            let event = alert.event              // Alert name
            let headline = alert.headline
            let desc = alert.desc
            
            let statement = "INSERT INTO '" + table +
            "' (alertId, type, areaDesc, effective, expires, severity, " +
            " event, headline, desc) " +
            " VALUES ('\(String(describing: alertId))', '\(String(describing: type))', " +
            " '\(String(describing: areaDesc))', '\(String(describing: effective))', " +
            " '\(String(describing: severity))', '\(String(describing: event))', '\(String(describing: expires))', " +
            "'\(String(describing: headline))', '\(String(describing: desc))');"
            
            if sqlite3_prepare_v2(sqlite3_db, statement, -1, &sqlite3_stmt, nil) != SQLITE_OK {
                let errmsg = String(cString: sqlite3_errmsg(sqlite3_db)!)
                print("Error preparing insert: \(errmsg)")
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

    
    func createAlert(table: String) -> Void {
        
        let queryString = "CREATE TABLE IF NOT EXISTS \(table) " +
            " ('Id' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL UNIQUE, 'alertId' TEXT, 'type' TEXT, 'areaDesc' TEXT, 'effective' TEXT, 'expires' TEXT, 'severity' TEXT," +
        " 'event' TEXT, 'headline' TEXT, 'desc' TEXT);"
        
        guard sqlite3_exec(sqlite3_db, queryString, nil, nil, nil) == SQLITE_OK else {
            let errmsg = String(cString: sqlite3_errmsg(sqlite3_db)!)
            print("Error creating table: \(errmsg)")
            return
        }
        // DEBUG
        print("Alert table \(table) created.")
    }
}

