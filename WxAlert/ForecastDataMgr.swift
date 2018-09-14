//
//  ForecastDataMgr.swift
//  WxAlert
//
//  Created by macbook on 8/28/18.
//  Copyright © 2018 Jaminya. All rights reserved.
//

import Foundation

class ForecastDataMgr {
    
    var forecast: WeekForecast?
    var table: String?
    
    init(forecast: WeekForecast, table: String) {
        self.forecast = forecast
        self.table = table
    }
    
    func writeForecast() -> Void {
        // TODO - Write to database
        print("Writing forecast to database.")
        

        var db: OpaquePointer? = nil
        var sqlite3_stmt: OpaquePointer? = nil
        
        let projectBundle = Bundle.main
        let resourcePath = projectBundle.path(forResource: "cities_usa", ofType: "sqlite")
        
        guard (sqlite3_open(resourcePath!, &db) == SQLITE_OK) else {
            print("Error opening database.")
            return
        }
        
        let tableName = self.table!
        guard let weather = forecast?.periods else { return }
        
        for day in weather {
            let number = day.number
            let name = day.name.cString(using: String.Encoding.utf8)
            let startTime = day.startTime.cString(using: String.Encoding.utf8)
            let endTime = day.endTime.cString(using: String.Encoding.utf8)
            let isdaytime = day.isDaytime
            let dayTime = (isdaytime == true) ? 1 : 0                                         // Convert Bool to Integer for SQLite
            
            let temperature = day.temperature
            let temperatureUnit = day.temperatureUnit.cString(using: String.Encoding.utf8)
            let temperatureTrend = day.temperatureTrend.cString(using: String.Encoding.utf8)
            let windSpeed = day.windSpeed.cString(using: String.Encoding.utf8)
            let windDirection = day.windDirection.cString(using: String.Encoding.utf8)
            let icon = day.icon.cString(using: String.Encoding.utf8)
            let shortForecast = day.shortForecast.cString(using: String.Encoding.utf8)
            let detailedForecast = day.detailedForecast.cString(using: String.Encoding.utf8)
            
            let statement = "INSERT INTO '" + tableName + "' (Id, Number, Name, StartTime, EndTime, isDayTime, Temperature, " +
            " TempUnit, WindSpeed, WindDirection, Icon, ShortForecast, DetailedForecast)" +
            " VALUES ('\(number)', '\(String(describing:name))', '\(String(describing:startTime))', '\(String(describing:endTime))', '\(dayTime)', " +
            " '\(temperature)', '\(String(describing:temperatureUnit))', '\(String(describing:temperatureTrend))', '\(String(describing:windSpeed))', " +
            " '\(String(describing:windDirection))', '\(String(describing:icon))', '\(String(describing:shortForecast))', '\(String(describing:detailedForecast))');"
        
            if sqlite3_prepare_v2(db, statement, -1, &sqlite3_stmt, nil) != SQLITE_OK {
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print("Error preparing insert: \(errmsg)")
                return
            }
            
            if sqlite3_step(sqlite3_stmt) != SQLITE_DONE {
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print("error msg: \(errmsg)")
            }
        } // for loop
        
        if  sqlite3_finalize(sqlite3_stmt) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db))
            print("Error finalizing prepared statement: \(errmsg)")
        }
        sqlite3_stmt = nil
 
 
        
        // Read db content
        var selectStatement: OpaquePointer? = nil
        let querySQL = "Select * FROM \(tableName);"
        if sqlite3_prepare_v2(db, querySQL, -1, &selectStatement, nil) == SQLITE_OK {
            while sqlite3_step(selectStatement) == SQLITE_ROW {
                let rowId = sqlite3_column_int(selectStatement, 0)
                let number = sqlite3_column_int(selectStatement, 1)
                let name = String(cString:sqlite3_column_text(selectStatement, 2))
                
                print("SQL select: \(rowId), \(number), \(name)")
            }
        }
        
        if  sqlite3_finalize(selectStatement) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db))
            print("Error finalizing prepared statement: \(errmsg)")
        }
        sqlite3_stmt = nil
        
        /*
        if sqlite3_close(db) != SQLITE_OK {
            print("Error closing database.")
        }
       */
        db = nil
    }
    
    func readForecast() {
        // TODO - 
    }
}
