//
//  DateUtils.swift
//  WxAlert
//
//  Created by macbook on 3/18/19.
//  Copyright © 2019 Jaminya. All rights reserved.
//

import Foundation

class DateUtils {
    
    class func format(dateTime: String?) -> (mm_dd: String, mm_dd_yy: String) {

        // Declare and initialize date tuple
        var date: (mm_dd: String, mm_dd_yy: String)
        date.mm_dd = "Jan 01"
        date.mm_dd_yy = "Jan 01, 1970"
        
        guard let dateTime = dateTime else { return date }
 
        let offSetIndex = dateTime.index(dateTime.startIndex, offsetBy: 10)
        let dateString = dateTime[..<offSetIndex]
        
        let dateComponents = dateString.split(separator: "-")
        let year = String(dateComponents[0])
        let number = String(dateComponents[1])
        let month = monthName(monthNumber: number)
        
        let dayNumber = String(dateComponents[2])
        date.mm_dd = month + " " + dayNumber
        date.mm_dd_yy = date.mm_dd + ", " + year
        
        return date
    }
    
    private class func monthName(monthNumber: String) -> String {
        
        var month: String = "Jan"
        
        switch monthNumber {
        case "01":
            month = "Jan"
        case "02":
            month = "Feb"
        case "03":
            month = "Mar"
        case "04":
            month = "Apr"
        case "05":
            month = "May"
        case "06":
            month = "Jun"
        case "07":
            month = "Jul"
        case "08":
            month = "Aug"
        case "09":
            month = "Sep"
        case "10":
            month = "Oct"
        case "11":
            month = "Nov"
        case "12":
            month = "Dec"
        default:
            month = "Err"
        }
        
        return month
    }
}
