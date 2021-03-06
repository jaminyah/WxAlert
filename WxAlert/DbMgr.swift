//
//  DbMgr.swift
//  WxAlert
//
//  Created by macbook on 8/22/18.
//  Copyright © 2018 Jaminya. All rights reserved.
//

import Foundation
import UIKit

class DbMgr {
    
    var sqlite3_db: OpaquePointer?
    static let sharedInstance = DbMgr()
    let wxUtils = WeatherUtils()
    
    private init() {
        
        var dbConnection: OpaquePointer? = nil
        let projectBundle = Bundle.main
        let resourcePath = projectBundle.path(forResource: "cities_usa", ofType: "sqlite")
        
        let flags = SQLITE_OPEN_READWRITE
        guard (sqlite3_open_v2(resourcePath!, &dbConnection, flags, nil) == SQLITE_OK) else {
            let errmsg = String(cString: sqlite3_errmsg(sqlite3_db)!)
            print("Error opening db : \(errmsg)")
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
        var sqlite3_stmt: OpaquePointer? = nil

        let count = searchTerm.count
         
         /*let sqlQry = "SELECT city, state_code, latitude, longitude FROM us_states JOIN us_cities ON " +
         "us_cities.ID_STATE = us_states.ID WHERE SUBSTR(city, 1, \(count))=? "
         */
         
            let subQuery = "(SELECT city, state_code, latitude, longitude FROM us_states INNER JOIN us_cities ON " +
            "us_cities.ID_STATE = us_states.ID WHERE SUBSTR(city, 1, \(count))=? ) sub "
         
            let sqlQuery = "SELECT sub.city, sub.state_code, sub.latitude, sub.longitude FROM \(subQuery) GROUP BY sub.state_code"
        
            if (sqlite3_prepare_v2(sqlite3_db, sqlQuery, -1, &sqlite3_stmt, nil) != SQLITE_OK)
            {
                print("Problem with prepared statement" + String(sqlite3_errcode(sqlite3_db)))
                // return
            }
            sqlite3_bind_text(sqlite3_stmt, 0, searchTerm, -1, SQLITE_TRANSIENT)
            sqlite3_bind_text(sqlite3_stmt, 1, searchTerm, -1, SQLITE_TRANSIENT)
            sqlite3_bind_text(sqlite3_stmt, 2, searchTerm, -1, SQLITE_TRANSIENT)
            sqlite3_bind_text(sqlite3_stmt, 3, searchTerm, -1, SQLITE_TRANSIENT)
         
            while (sqlite3_step(sqlite3_stmt) == SQLITE_ROW) {
         
                let sqlName = String(cString:sqlite3_column_text(sqlite3_stmt, 0))
                let concatName: String = String(cString:sqlite3_column_text(sqlite3_stmt, 0)) + ", " +
                String(cString:sqlite3_column_text(sqlite3_stmt, 1))
         
         // Ensure no duplicate entries. Item already in database; continue
         //if filteredList.index(where: { $0 == concatName}) != nil {
         //   continue
         //}
         
                dataItem.filteredList.append(concatName)
         
                let sqlRegion = String(cString:sqlite3_column_text(sqlite3_stmt, 1))
                let sqLat = String(cString:sqlite3_column_text(sqlite3_stmt, 2))
                let sqLong = String(cString:sqlite3_column_text(sqlite3_stmt, 3))
         
                let sqLatReal = Double(sqLat)                               // String to Double
                let sqLongReal = Double(sqLong)
                let newCoordinates = Coordinates(latitude: sqLatReal!, longitude: sqLongReal!)
         
                cityObject = City(name: sqlName, state: sqlRegion, coordinates: newCoordinates)
                dataItem.cityList.append(cityObject)
            }
            sqlite3_finalize(sqlite3_stmt)
 
        return dataItem
    }
    
    
    func createWx(table: String) -> Void {
        
        let queryString = "CREATE TABLE IF NOT EXISTS \(table) " +
            " ('Id' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL UNIQUE, 'Number' INTEGER, 'Name' TEXT, 'StartTime' TEXT, 'EndTime' TEXT, 'isDayTime' INTEGER, 'Temperature' INTEGER," +
        " 'TempUnit' TEXT, 'TempTrend' TEXT, 'WindSpeed' TEXT, 'WindDirection' TEXT, 'Icon' TEXT, 'ShortForecast' TEXT, 'DetailedForecast' TEXT);"
        
        guard sqlite3_exec(sqlite3_db, queryString, nil, nil, nil) == SQLITE_OK else {
            let errmsg = String(cString: sqlite3_errmsg(sqlite3_db)!)
            print("Error creating table: \(errmsg)")
            return
        }
        print("Table \(table) created.")
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
    
    func insert(sevenDay:[DayForecast], city: String, stateID: String) -> Void {
        
        var sqlite3_stmt: OpaquePointer? = nil
        var zSql = String()
        var number: Int = 0
        var name = String()
        var startTime = String()
        var endTime = String()
        var isdaytime: Bool = false
        var dayTime: Int = 0
        var temperature: Int = 0
        var temperatureUnit = String()
        var temperatureTrend = String()
        var windSpeed = String()
        var windDirection = String()
        var icon = String()
        var shortForecast = String()
        var detailedForecast = String()
        
        let wxtable = StringUtils.concat(name: city, state: stateID)
        
        // Clear sqlite3 table data
        var sql = "DELETE FROM \(wxtable)"
        guard sqlite3_exec(sqlite3_db, sql, nil, nil, nil) == SQLITE_OK else {
            let errmsg = String(cString: sqlite3_errmsg(sqlite3_db)!)
            print("Delete error: \(errmsg)")
            return
        }
        sql = "VACUUM"
        guard sqlite3_exec(sqlite3_db, sql, nil, nil, nil) == SQLITE_OK else {
            let errmsg = String(cString: sqlite3_errmsg(sqlite3_db)!)
            print("Vacuum error: \(errmsg)")
            return
        }
        
        for day in sevenDay {
            number = day.number
            name = day.name
            //print("insertSevenDay: \(name)")
            startTime = day.startTime
            //print("insertSevenDay: \(day.startTime)")
            endTime = day.endTime
            //print("insertSevenDay: \(day.endTime)")
            isdaytime = day.isDaytime
            //print("insertSevenDay: \(isdaytime)")
            dayTime = (isdaytime == true) ? 1 : 0             // Convert Bool to Integer for SQLite
            temperature = day.temperature
            temperatureUnit = day.temperatureUnit
            //print("insertSevenDay: \(temperatureUnit)")
            temperatureTrend = day.temperatureTrend
            windSpeed = day.windSpeed
            windDirection = day.windDirection
            icon = day.icon
            shortForecast = day.shortForecast
            detailedForecast = day.detailedForecast
                        
            //query = "INSERT INTO \(wxtable) (Number, Name, StartTime, EndTime, isDayTime, Temperature, TempUnit, TempTrend, WindSpeed, WindDirection, Icon, ShortForecast, DetailedForecast) VALUES (\(number), '\(name)', '\(startTime)', '\(endTime)', \(dayTime), \(temperature), '\(temperatureUnit)', '\(temperatureTrend)' ,'\(windSpeed)', '\(windDirection)', '\(icon)', '\(shortForecast)', '\(detailedForecast)');"
            
            zSql = "INSERT INTO \(wxtable) (Number, Name, StartTime, EndTime, isDayTime, Temperature, TempUnit, TempTrend, WindSpeed, WindDirection, Icon, ShortForecast, DetailedForecast) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);"
            
            if sqlite3_prepare_v2(sqlite3_db, zSql, -1, &sqlite3_stmt, nil) != SQLITE_OK {
                let errmsg = String(cString: sqlite3_errmsg(sqlite3_db)!)
                print("Insert sevenDay, error preparing insert: \(errmsg)")
                return
            }
            
            sqlite3_bind_int(sqlite3_stmt, 1, Int32(number))
            sqlite3_bind_text(sqlite3_stmt, 2, name, -1, SQLITE_TRANSIENT)
            sqlite3_bind_text(sqlite3_stmt, 3, startTime, -1, SQLITE_TRANSIENT)
            sqlite3_bind_text(sqlite3_stmt, 4, endTime, -1, SQLITE_TRANSIENT)
            sqlite3_bind_int(sqlite3_stmt, 5, Int32(dayTime))
            sqlite3_bind_int(sqlite3_stmt, 6, Int32(temperature))
            sqlite3_bind_text(sqlite3_stmt, 7, temperatureUnit, -1, SQLITE_TRANSIENT)
            sqlite3_bind_text(sqlite3_stmt, 8, temperatureTrend, -1, SQLITE_TRANSIENT)
            sqlite3_bind_text(sqlite3_stmt, 9, windSpeed, -1, SQLITE_TRANSIENT)
            sqlite3_bind_text(sqlite3_stmt, 10, windDirection, -1, SQLITE_TRANSIENT)
            sqlite3_bind_text(sqlite3_stmt, 11, icon, -1, SQLITE_TRANSIENT)
            sqlite3_bind_text(sqlite3_stmt, 12, shortForecast, -1, SQLITE_TRANSIENT)
            sqlite3_bind_text(sqlite3_stmt, 13, detailedForecast, -1, SQLITE_TRANSIENT)
            
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
        
        // Broadcast data has been updated
        let citySender = [city: stateID]
        let notice = StringUtils.concat(name: city, state: stateID)
        let didUpdate = Notification.init(name: notice, enabled: true)
        
        // Notification to update weather view
        NotificationCenter.default.post(name: .didUpdateWeather, object: self, userInfo: citySender)
        
        // Notification to start countdown timer
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: didUpdate.name), object: self, userInfo: citySender)
    }
    
    func dayForecast(from: String, sql: String) -> [CellModel] {
        
        var dayArray: [String?] = []
        var forecast: [CellModel] = []
        let tableName = from
        
        var sqlite3_stmt: OpaquePointer? = nil
        let statement = sql
        
        if sqlite3_prepare_v2(sqlite3_db, statement, -1, &sqlite3_stmt, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(sqlite3_db)!)
            print("Error reading sqlite data: \(errmsg)")
        }
        
        var cellModel = CellModel()
        while (sqlite3_step(sqlite3_stmt) == SQLITE_ROW) {
            cellModel.day = String(cString:sqlite3_column_text(sqlite3_stmt, 2)!)
            
            // Set wxViewCell date
            cellModel.date = String(cString:sqlite3_column_text(sqlite3_stmt, 3)!)
            //print("cellModel.date: \(cellModel.date)")
            
            // Set day icons
            cellModel.dayNightIcon = UIImage(imageLiteralResourceName: "sun_icon")
            
            cellModel.hiTemp = "Hi: " + String(sqlite3_column_int(sqlite3_stmt, 6)) + "\u{00B0}F"
            
            // Wind data
            cellModel.windSpeed = String(cString:sqlite3_column_text(sqlite3_stmt, 9)!)
            cellModel.windDirection = String(cString:sqlite3_column_text(sqlite3_stmt, 10)!)
            cellModel.windIcon = wxUtils.wind(direction: cellModel.windDirection!)
            
            let iconString = String(cString:sqlite3_column_text(sqlite3_stmt, 11))
            let iconModel = wxUtils.parse(urlString: iconString)
            
            cellModel.wxIcon = iconModel.image
            cellModel.wxChance = iconModel.chance
            
            cellModel.shortForecast = String(cString:sqlite3_column_text(sqlite3_stmt, 12))
            cellModel.detailedForecast = String(cString:sqlite3_column_text(sqlite3_stmt, 13))
 
            forecast.append(cellModel)
        }
        
        // Set non-weekday names to nil
        for element in forecast {
            let item = wxUtils.filterValid(day: element.day)
            dayArray.append(item)
        }
        
        // Remove any nils from the array
        let array = wxUtils.removeNil(dayNames: dayArray, mode: "Day")
        for (index, period) in array.enumerated() {
            if let trimmed = wxUtils.trim(day: period) {
                forecast[index].day = trimmed
            }
        }
        
        let query2 = "SELECT * FROM \(tableName) WHERE isDayTime == 0;"
        forecast = addNightlyLows(sql: query2, models: forecast)
        
        sqlite3_finalize(sqlite3_stmt)
        return forecast
    }
    
    private func addNightlyLows(sql: String, models: [CellModel]) -> [CellModel] {
        
        var forecast = models
        var sqlite3_stmt: OpaquePointer? = nil
        let statement = sql
        
        if sqlite3_prepare_v2(sqlite3_db, statement, -1, &sqlite3_stmt, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(sqlite3_db)!)
            print("Error reading sqlite data: \(errmsg)")
        }
        
        var dailyLows: [String] = []
        var lowTemp: String = ""
        while (sqlite3_step(sqlite3_stmt) == SQLITE_ROW) {

            lowTemp = "Low: " + String(sqlite3_column_int(sqlite3_stmt, 6)) + "\u{00B0}F"
            dailyLows.append(lowTemp)
        }
        sqlite3_finalize(sqlite3_stmt)
        
        var index = 0
        while index < forecast.count {
            forecast[index].lowTemp = dailyLows[index]
            index += 1
        }
        return forecast
    }
    
    
    func dayNightForecast(sql: String) -> [CellModel] {
        
        var forecast: [CellModel] = []
        var dayArray: [String?] = []
        
        var sqlite3_stmt: OpaquePointer? = nil
        let statement = sql
        
        if sqlite3_prepare_v2(sqlite3_db, statement, -1, &sqlite3_stmt, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(sqlite3_db)!)
            print("Error reading sqlite data: \(errmsg)")
        }
        
        var cellModel = CellModel()
        while (sqlite3_step(sqlite3_stmt) == SQLITE_ROW) {
            cellModel.day = String(cString:sqlite3_column_text(sqlite3_stmt, 2)!)
            
            // Set wxViewCell date
            cellModel.date = String(cString:sqlite3_column_text(sqlite3_stmt, 3)!)
            
            let isDaytime = sqlite3_column_int(sqlite3_stmt, 5)
            if isDaytime == 1 {
                cellModel.hiTemp = "Hi: " + String(sqlite3_column_int(sqlite3_stmt, 6)) + "\u{00B0}F"
                cellModel.lowTemp = nil
                cellModel.dayNightIcon = UIImage(imageLiteralResourceName: "sun_icon")
            } else {
                cellModel.hiTemp = nil
                cellModel.lowTemp = "Low: " + String(sqlite3_column_int(sqlite3_stmt, 6)) + "\u{00B0}F"
                cellModel.dayNightIcon = UIImage(imageLiteralResourceName: "moon_icon")
            }

            cellModel.windSpeed = String(cString:sqlite3_column_text(sqlite3_stmt, 9))
            cellModel.windDirection = String(cString:sqlite3_column_text(sqlite3_stmt, 10))
            cellModel.windIcon = wxUtils.wind(direction: cellModel.windDirection!)
            
            let iconString = String(cString:sqlite3_column_text(sqlite3_stmt, 11))
            let iconModel = wxUtils.parse(urlString: iconString)
            
            cellModel.wxIcon = iconModel.image
            cellModel.wxChance = iconModel.chance
            
            cellModel.shortForecast = String(cString:sqlite3_column_text(sqlite3_stmt, 12))
            cellModel.detailedForecast = String(cString:sqlite3_column_text(sqlite3_stmt, 13))
            
            forecast.append(cellModel)
        }
        
        // Set non-weekday names to nil
        for element in forecast {
            let item = wxUtils.filterValid(day: element.day)
            dayArray.append(item)
        }
        
        // Remove any nils from the array
        let array = wxUtils.removeNil(dayNames: dayArray, mode: "Day+Night")
        for (index, period) in array.enumerated() {
            if let trimmed = wxUtils.trim(day: period) {
                forecast[index].day = trimmed
            }
        }
        
        sqlite3_finalize(sqlite3_stmt)
        return forecast
    }
    
    func nightForecast(sql: String) -> [CellModel] {
        
        var dayArray: [String?] = []
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
            
            // Set wxViewCell date
            cellModel.date = String(cString:sqlite3_column_text(sqlite3_stmt, 3)!)
            
            cellModel.hiTemp = nil
            cellModel.dayNightIcon = UIImage(imageLiteralResourceName: "moon_icon")
            cellModel.lowTemp = "Low: " + String(sqlite3_column_int(sqlite3_stmt, 6)) + "\u{00B0}F"
            
            cellModel.windSpeed = String(cString:sqlite3_column_text(sqlite3_stmt, 9))
            cellModel.windDirection = String(cString:sqlite3_column_text(sqlite3_stmt, 10))
            cellModel.windIcon = wxUtils.wind(direction: cellModel.windDirection!)
            
            let iconString = String(cString:sqlite3_column_text(sqlite3_stmt, 11))
            let iconModel = wxUtils.parse(urlString: iconString)
            
            cellModel.wxIcon = iconModel.image
            cellModel.wxChance = iconModel.chance
            
            cellModel.shortForecast = String(cString:sqlite3_column_text(sqlite3_stmt, 12))
            cellModel.detailedForecast = String(cString:sqlite3_column_text(sqlite3_stmt, 13))
 
            forecast.append(cellModel)
        }
        
        // Set non-weekday names to nil
        for element in forecast {
            let item = wxUtils.filterValid(day: element.day)
            dayArray.append(item)
        }
        
        // Remove nil element from array
        let array = wxUtils.removeNil(dayNames: dayArray, mode: "Night")
        for (index, period) in array.enumerated() {
            if let trimmed = wxUtils.trim(day: period) {
                forecast[index].day = trimmed
            }
        }
        
        sqlite3_finalize(sqlite3_stmt)
        return forecast
    }
    
    func fetchEndTime(from table: String) -> String {
        
        var firstEndTime = String()
        
        var sqlite3_stmt: OpaquePointer? = nil
        let statement = "SELECT * FROM \(table) WHERE Number == 1;"
        
        if sqlite3_prepare_v2(sqlite3_db, statement, -1, &sqlite3_stmt, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(sqlite3_db)!)
            print("Error reading sqlite data: \(errmsg)")
        }
        
        while (sqlite3_step(sqlite3_stmt) == SQLITE_ROW) {
            
            firstEndTime = String(cString:sqlite3_column_text(sqlite3_stmt, 4)!)
           // break
        }
        return firstEndTime
    }
    
} // DbMgr
