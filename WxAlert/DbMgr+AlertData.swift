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
        var statement = String()
        var zSql: [CChar]?
        
        var alertId = String()
        var event = String()
        
        for alert in alerts {
            
            alertId = alert.alertId
            
            /*
            let type = alert.type
            let areaDesc = alert.areaDesc
            let sent = alert.sent
            let effective = alert.effective
            let expires = alert.expires
            let ends = alert.ends
            let status = alert.status
            let messageType = alert.messageType
            let category = alert.category
            let severity = alert.severity
            let certainty = alert.certainty
            let urgency = alert.urgency
            */
            event = alert.event
            /*
            let sender = alert.sender
            let senderName = alert.senderName
            let headline = alert.headline
            let description = alert.description
            let instruction = alert.instruction
            let response = alert.response
            */
            
            /*
            let statement = "INSERT INTO '" + table + "' (AlertId, Type, AreaDesc, Sent, Effective, " +
            " Expires, Ends, Status, MessageType, Category, Severity, " +
            " Certainty, Urgency, Event, Sender, SenderName, Headline, Description, Instruction, Response)" +
            " VALUES ('\(String(describing: alertId))', '\(String(describing: type))', " +
            " '\(String(describing: areaDesc))', '\(String(describing: sent))', " +
            " '\(String(describing: effective))', '\(String(describing: expires))', '\(String(describing: ends))', " +
            " '\(String(describing: status))', '\(String(describing: messageType))', " +
            " '\(String(describing: category))', '\(String(describing: severity))', " +
            " '\(String(describing: certainty))', '\(String(describing: urgency))', " +
            " '\(String(describing: event))', '\(String(describing: sender))', " +
            " '\(String(describing: senderName))', '\(String(describing: headline))', " +
            " '\(String(describing: description))', '\(String(describing: instruction))', " +
            " '\(String(describing: response))');"
            */
            // let statement = "INSERT INTO \(table) (AlertId, Event) VALUES ('" + alertId + "','" + event + "');"
            statement = "INSERT INTO \(table) (AlertId, Event) VALUES ('\(alertId)','\(event)');"
            zSql = statement.cString(using: String.Encoding.utf8)
            
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
            
            /*
            model.type = String(cString:sqlite3_column_text(sqlite3_stmt, 2)!)
            model.areaDesc = String(cString:sqlite3_column_text(sqlite3_stmt, 3)!)
            model.sent = String(cString:sqlite3_column_text(sqlite3_stmt, 4)!)
            model.effective = String(cString:sqlite3_column_text(sqlite3_stmt, 5)!)
            model.expires = String(cString:sqlite3_column_text(sqlite3_stmt, 6)!)
            model.ends = String(cString:sqlite3_column_text(sqlite3_stmt, 7)!)
            model.status = String(cString:sqlite3_column_text(sqlite3_stmt, 8)!)
            model.messageType = String(cString:sqlite3_column_text(sqlite3_stmt, 9)!)
            model.category = String(cString:sqlite3_column_text(sqlite3_stmt, 10)!)
            model.severity = String(cString:sqlite3_column_text(sqlite3_stmt, 11)!)
            model.certainty = String(cString:sqlite3_column_text(sqlite3_stmt, 12)!)
            model.urgency = String(cString:sqlite3_column_text(sqlite3_stmt, 13)!)
            */
            model.event = String(cString:sqlite3_column_text(sqlite3_stmt, 2)!)
            /*
            model.sender = String(cString:sqlite3_column_text(sqlite3_stmt, 15)!)
            model.senderName = String(cString:sqlite3_column_text(sqlite3_stmt, 16)!)
            model.headline = String(cString:sqlite3_column_text(sqlite3_stmt, 17)!)
            model.description = String(cString:sqlite3_column_text(sqlite3_stmt, 18)!)
            model.instruction = String(cString:sqlite3_column_text(sqlite3_stmt, 19)!)
            model.response = String(cString:sqlite3_column_text(sqlite3_stmt, 20)!)
            */

            alertModels.append(model)
        }
        
        return alertModels
    }

    
    func createAlert(table: String) -> Void {
        
        /*
        let queryString = "CREATE TABLE IF NOT EXISTS \(table) " +
            " ('Id' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL UNIQUE, 'AlertId' TEXT, 'Type' TEXT, 'AreaDesc' TEXT, " +
            "'Sent' TEXT, 'Effective' TEXT, 'Expires' TEXT, 'Ends' TEXT, 'Status', TEXT, 'MessageType' TEXT," +
            " 'Category' TEXT, 'Severity' TEXT, 'Certainty' TEXT, 'Urgency' TEXT, 'Event' TEXT, 'Sender' TEXT," +
            " 'SenderName' TEXT, 'Headline' TEXT, 'Description' TEXT, 'Instruction' TEXT, 'Response' TEXT);"
        */
        let query = "CREATE TABLE IF NOT EXISTS \(table) ('Id' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL UNIQUE, 'AlertId' TEXT, 'Event' TEXT);"
        
        guard sqlite3_exec(sqlite3_db, query, nil, nil, nil) == SQLITE_OK else {
            let errmsg = String(cString: sqlite3_errmsg(sqlite3_db)!)
            print("Error creating table: \(errmsg)")
            return
        }
        // DEBUG
        print("Alert table \(table) created.")
    }
}

