//
//  Constants.swift
//  WxAlert
//
//  Created by macbook on 3/20/18.
//  Copyright © 2018 Jaminya. All rights reserved.
//

import Foundation


// Notification Center
let CITY_LIST_MODIFIED = NSNotification.Name("CityListModified")


// UITableView Data Source
let ONE_SECTION = 1

let FORECAST_URL = "http://cdn.jaminya.com/json/forecast.json"
let FORECAST_URL2 = "http://cdn.jaminya.com/json/forecast9739.json"
let FORECAST_URL3 = "http://cdn.jaminya.com/json/forecast8025.json"

let EPOCH_TIME_REFERENCE = "1970-01-01T00:00:00Z"
let UNIX_EPOCH_DATE = "Thurs, Jan 01, 1970"
let UNIX_EPOCH = "Jan 01, 1970"

// Sqlite3
let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
let SQLITE_STATIC = unsafeBitCast(0, to: sqlite3_destructor_type.self)

// Generator for 30 - 40 minutes
let LOWER = 1800      // 30 x 60 seconds
let UPPER = 2400      // 40 x 60 seconds
