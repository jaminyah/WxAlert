//
//  DbMgr.swift
//  WxAlert
//
//  Created by macbook on 8/22/18.
//  Copyright © 2018 Jaminya. All rights reserved.
//

import Foundation

class DbMgr {
    
    var sqlite3_db: OpaquePointer? = nil
    static let sharedInstance = DbMgr()
    
    private init() {
        
        var dbConnection: OpaquePointer? = nil
        let projectBundle = Bundle.main
        let resourcePath = projectBundle.path(forResource: "cities_usa", ofType: "sqlite")
        
        let flags = SQLITE_OPEN_READWRITE
        guard (sqlite3_open_v2(resourcePath!, &dbConnection, flags, nil) == SQLITE_OK) else {
            let errmsg = String(cString: sqlite3_errmsg(sqlite3_db)!)
            print("Error openning db : \(errmsg)")
            return
        }
        sqlite3_db = dbConnection
    }
    
    
    func closeDatabase() -> Void {
        sqlite3_close(sqlite3_db)
    }

    
    func getSearchList(searchTerm: String) -> DataItem {
        
        var cityObject = City()
        var dataItem = DataItem()
        
        var sqlStatement: OpaquePointer? = nil
        let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
        
        let count = searchTerm.count
         
         /*let sqlQry = "SELECT city, state_code, latitude, longitude FROM us_states JOIN us_cities ON " +
         "us_cities.ID_STATE = us_states.ID WHERE SUBSTR(city, 1, \(count))=? "
         */
         
            let subQuery = "(SELECT city, state_code, latitude, longitude FROM us_states INNER JOIN us_cities ON " +
            "us_cities.ID_STATE = us_states.ID WHERE SUBSTR(city, 1, \(count))=? ) sub "
         
            let sqlQuery = "SELECT sub.city, sub.state_code, sub.latitude, sub.longitude FROM \(subQuery) GROUP BY sub.state_code"
         
         
            if (sqlite3_prepare_v2(sqlite3_db, sqlQuery, -1, &sqlStatement, nil) != SQLITE_OK)
            {
                print("Problem with prepared statement" + String(sqlite3_errcode(sqlite3_db)))
                // return
            }
            sqlite3_bind_text(sqlStatement, 0, searchTerm, -1, SQLITE_TRANSIENT)
            sqlite3_bind_text(sqlStatement, 1, searchTerm, -1, SQLITE_TRANSIENT)
            sqlite3_bind_text(sqlStatement, 2, searchTerm, -1, SQLITE_TRANSIENT)
            sqlite3_bind_text(sqlStatement, 3, searchTerm, -1, SQLITE_TRANSIENT)
         
            while (sqlite3_step(sqlStatement) == SQLITE_ROW) {
         
                let sqlName = String(cString:sqlite3_column_text(sqlStatement, 0))
         
                let concatName: String = String(cString:sqlite3_column_text(sqlStatement, 0)) + ", " +
                String(cString:sqlite3_column_text(sqlStatement, 1))
         
         // Ensure no duplicate entries. Item already in database; continue
         //if filteredList.index(where: { $0 == concatName}) != nil {
         //   continue
         //}
         
                dataItem.filteredList.append(concatName)
         
                let sqlRegion = String(cString:sqlite3_column_text(sqlStatement, 1))
                let sqLat = String(cString:sqlite3_column_text(sqlStatement, 2))
                let sqLong = String(cString:sqlite3_column_text(sqlStatement, 3))
         
                let sqLatReal = Double(sqLat)                               // String to Double
                let sqLongReal = Double(sqLong)
                let newCoordinates = Coordinates(latitude: sqLatReal!, longitude: sqLongReal!)
         
                cityObject = City(name: sqlName, state: sqlRegion, coordinates: newCoordinates)
                dataItem.cityList.append(cityObject)
            }
            sqlite3_finalize(sqlStatement)
 
        return dataItem
    }
    
    
    func createTable(name: String) -> Void {
        
        let queryString = "CREATE TABLE IF NOT EXISTS \(name) " +
            " ('Id' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL UNIQUE, 'Number' INTEGER, 'Name' TEXT, 'StartTime' TEXT, 'EndTime' TEXT, 'isDayTime' INTEGER, 'Temperature' INTEGER," +
        " 'TempUnit' TEXT, 'TempTrend' TEXT, 'WindSpeed' TEXT, 'WindDirection' TEXT, 'Icon' TEXT, 'ShortForecast' TEXT, 'DetailedForecast' TEXT, 'Alert' TEXT);"
        
        guard sqlite3_exec(sqlite3_db, queryString, nil, nil, nil) == SQLITE_OK else {
            let errmsg = String(cString: sqlite3_errmsg(sqlite3_db)!)
            print("Error creating table: \(errmsg)")
            return
        }
        print("Table \(name) created.")
    }
    
    
    func dropTable(name: String) -> Void {
        
        let queryString = "Drop TABLE IF EXISTS \(name);"
        
        guard sqlite3_exec(sqlite3_db, queryString, nil, nil, nil) == SQLITE_OK else {
            let errmsg = String(cString: sqlite3_errmsg(sqlite3_db)!)
            print("Error creating table: \(errmsg)")
            return
        }
        print("Table \(name) dropped.")
    }
    
    
    func insertSevenDay(weather:[DayForecast], table:String) -> Void {
        
        var sqlite3_stmt: OpaquePointer? = nil
        
        for day in weather {
            let number = day.number
           // let name = day.name.cString(using: String.Encoding.utf8)
            let name = day.name
            print("insertSevenDay: \(name)")
            let startTime = day.startTime
            print("insertSevenDay: \(day.startTime)")
            let endTime = day.endTime
            print("insertSevenDay: \(day.endTime)")
            let isdaytime = day.isDaytime
            print("insertSevenDay: \(isdaytime)")
            let dayTime = (isdaytime == true) ? 1 : 0             // Convert Bool to Integer for SQLite
            let temperature = day.temperature
            let temperatureUnit = day.temperatureUnit
            print("insertSevenDay: \(temperatureUnit)")
            let temperatureTrend = day.temperatureTrend.cString(using: String.Encoding.utf8)
            let windSpeed = day.windSpeed.cString(using: String.Encoding.utf8)
            let windDirection = day.windDirection.cString(using: String.Encoding.utf8)
            let icon = day.icon.cString(using: String.Encoding.utf8)
            let shortForecast = day.shortForecast.cString(using: String.Encoding.utf8)
            let detailedForecast = day.detailedForecast.cString(using: String.Encoding.utf8)
            
            let statement = "INSERT INTO '" + table + "' (Number, Name, StartTime, EndTime, isDayTime, Temperature, " +
                " TempUnit, TempTrend, WindSpeed, WindDirection, Icon, ShortForecast, DetailedForecast)" +
                " VALUES ('\(number)', '\(String(describing:name))', '\(String(describing:startTime))', '\(String(describing:endTime))', " +
                " '\(dayTime)', '\(temperature)', '\(String(describing:temperatureUnit))', '\(String(describing:temperatureTrend))',  " +
                " '\(String(describing:windSpeed))', '\(String(describing:windDirection))', '\(String(describing:icon))', " +
                " '\(String(describing:shortForecast))', '\(String(describing:detailedForecast))');"
            
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
    
    func readForecast(from: String, sql: String) -> [CellModel] {
        // TODO - Read sqlite, populate properties
        var forecast: [CellModel] = []
        
        var sqlite3_stmt: OpaquePointer? = nil
        let statement = sql
        
        if sqlite3_prepare_v2(sqlite3_db, statement, -1, &sqlite3_stmt, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(sqlite3_db)!)
            print("Error reading sqlite data: \(errmsg)")
        }
        
        var cellModel = CellModel()
        while (sqlite3_step(sqlite3_stmt) == SQLITE_ROW) {
            cellModel.day = String(cString:sqlite3_column_text(sqlite3_stmt, 2)!)
            //let day = cellModel.day
            //print("cellModel.day: \(day)")
            
            print("cellModel.day: \(cellModel.day)")
            cellModel.hiTemp = String(cString:sqlite3_column_text(sqlite3_stmt, 6))
            cellModel.windSpeed = String(cString:sqlite3_column_text(sqlite3_stmt, 8))
            cellModel.windDirection = String(cString:sqlite3_column_text(sqlite3_stmt, 9))
            cellModel.rain = String(cString:sqlite3_column_text(sqlite3_stmt, 11))
            cellModel.wxIcon = #imageLiteral(resourceName: "Sun")   // String(cString:sqlite3_column_text(sqlite3_stmt, 10))
            cellModel.alertIcon = #imageLiteral(resourceName: "alert")
 
            forecast.append(cellModel)
            

        }
        sqlite3_finalize(sqlite3_stmt)
        return forecast
    }
    
   private func readLowTemperature(from: String) -> [String] {
        // TODO - Read sqlite night-time temperature, set low temperature property
        let temp = [String]()
        return temp
    }
    
} // DbMgr