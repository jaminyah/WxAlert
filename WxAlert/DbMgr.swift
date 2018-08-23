//
//  DbMgr.swift
//  WxAlert
//
//  Created by macbook on 8/22/18.
//  Copyright © 2018 Jaminya. All rights reserved.
//

import Foundation

class DbMgr {
    
    static let sharedInstance = DbMgr()
    private init() {}

    func getSearchList(searchTerm: String) -> DataItem {
        
        let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
        var cityObject = City()
        var dataItem = DataItem()
        
        var fileExist = false
        var db: OpaquePointer? = nil
        var sqlStatement: OpaquePointer? = nil
        
         let projectBundle = Bundle.main
         let fileMgr = FileManager.default
         let resourcePath = projectBundle.path(forResource: "cities_usa", ofType: "sqlite")
         
         fileExist = fileMgr.fileExists(atPath: resourcePath!)
         
         if (fileExist) {
            if (!(sqlite3_open(resourcePath!, &db) == SQLITE_OK))
         {
            print("An error has occurred.")
         }
         else {
            let count = searchTerm.count
         
         /*let sqlQry = "SELECT city, state_code, latitude, longitude FROM us_states JOIN us_cities ON " +
         "us_cities.ID_STATE = us_states.ID WHERE SUBSTR(city, 1, \(count))=? "
         */
         
            let subQuery = "(SELECT city, state_code, latitude, longitude FROM us_states INNER JOIN us_cities ON " +
            "us_cities.ID_STATE = us_states.ID WHERE SUBSTR(city, 1, \(count))=? ) sub "
         
            let sqlQuery = "SELECT sub.city, sub.state_code, sub.latitude, sub.longitude FROM \(subQuery) GROUP BY sub.state_code"
         
         
            if (sqlite3_prepare_v2(db, sqlQuery, -1, &sqlStatement, nil) != SQLITE_OK)
            {
                print("Problem with prepared statement" + String(sqlite3_errcode(db)))
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
         
                let sqLatReal = Double(sqLat)      // String to Double
                let sqLongReal = Double(sqLong)
                let newCoordinates = Coordinates(latitude: sqLatReal!, longitude: sqLongReal!)
         
                cityObject = City(name: sqlName, state: sqlRegion, coordinates: newCoordinates)
                dataItem.cityList.append(cityObject)
            }
            sqlite3_finalize(sqlStatement)
            sqlite3_close(db)
         }
        }
        return dataItem
    }
}
