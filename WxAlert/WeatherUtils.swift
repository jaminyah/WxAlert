//
//  WeatherUtils.swift
//  WxAlert
//
//  Created by macbook on 10/23/18.
//  Copyright © 2018 Jaminya. All rights reserved.
//

import Foundation
import UIKit

class WeatherUtils {
    init() {}
    
    func wind(direction: String) -> UIImage? {
        
        var windIcon: UIImage?
        
        switch (direction) {
        case "N":
            windIcon = #imageLiteral(resourceName: "wind_north")
        case "NE", "NNE", "ENE":
            windIcon = #imageLiteral(resourceName: "wind_northeast")
        case "NW", "NNW", "WNW":
            windIcon = #imageLiteral(resourceName: "wind_northwest")
        case "E":
            windIcon = #imageLiteral(resourceName: "wind_east")
        case "SE", "ESE", "SSE":
            windIcon = #imageLiteral(resourceName: "wind_southeast")
        case "S":
            windIcon = #imageLiteral(resourceName: "wind_south")
        case "SW", "SSW", "WSW":
            windIcon = #imageLiteral(resourceName: "wind_southwest")
        case "W":
            windIcon = #imageLiteral(resourceName: "wind_west")
        case "---":
            windIcon = UIImage(imageLiteralResourceName: "alert_wind")
        default:
            windIcon = nil
        }
        
        return windIcon
    }
    
    func trim(day: String) -> String? {
        
        var dayName:String? = nil
        
        switch(day) {
        case "Sunday", "Sunday Night" : dayName = "Sun"
        case "Monday", "Monday Night" : dayName = "Mon"
        case "Tuesday", "Tuesday Night" : dayName = "Tues"
        case "Wednesday", "Wednesday Night" : dayName = "Wed"
        case "Thursday", "Thursday Night" : dayName = "Thurs"
        case "Friday", "Friday Night" : dayName = "Fri"
        case "Saturday", "Saturday Night" : dayName = "Sat"
        default:
            dayName = nil
        }
        return dayName
    }
    
    func previous(day: String) -> String {
        
        var previousDay: String = " "
        
        switch (day) {
        case "Sun": previousDay = "Sat"
        case "Mon": previousDay = "Sun"
        case "Tues": previousDay = "Mon"
        case "Wed": previousDay =  "Tues"
        case "Thurs": previousDay = "Wed"
        case "Fri": previousDay = "Thurs"
        case "Sat": previousDay = "Fri"
        default:
            print("Day error")
        }
        return previousDay
    }
    
    func next(day: String) -> String {
        
        var nextDay: String = " "
        
        switch (day) {
        case "Sun": nextDay = "Mon"
        case "Mon": nextDay = "Tues"
        case "Tues": nextDay = "Wed"
        case "Wed": nextDay =  "Thurs"
        case "Thurs": nextDay = "Fri"
        case "Fri": nextDay = "Sat"
        case "Sat": nextDay = "Sun"
        default:
            print("Day error")
        }
        return nextDay
    }
    
    func removeNil(dayNames: [String?]) -> [String] {
        var dayList: [String] = []
        var days: [String?] = []
        
        // Create a mutable copy of dayNames array
        for day in dayNames {
            days.append(day)
        }
        
        var index = 0
        var day: String? = nil
        while (index < days.count) {
            day = days[index]
            
            switch day {
            case nil:
                if (index == 0) {
                    while index < days.count {
                        if days[index] == nil {
                            index = index + 1
                            continue
                        }
                        else {
                            let today = days[index]
                            let previousDay = previous(day: today!)
                            days[index - 1] = previousDay
                            break
                        }
                    }
                    // reset index of outer loop to re-start nil check
                    index = 0
                    continue
                }
                else if (index <= days.count - 1) {
                    if let previousDay = days[index - 1] {
                        let nextDay = next(day: previousDay)
                        days[index] = nextDay
                        
                        // reset index of outer loop to re-start nil check
                        index = 0
                        continue
                    }
                }
            default:
                index = index + 1
                continue
            }
        }
            
        // Copy non-nil days
        for day in days {
            if let dayName = day {
                dayList.append(dayName)
            }
        }
        return dayList
    }
    

    func parse(url: URL) -> [String] {
        
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let path = components?.path
        print(path!)
        
        let elements = path?.components(separatedBy: "/")
        print("parse: \(elements!)")
        
        return elements!
        
    }
    
    func split(compoundString: String) -> (icon: String, percentage: String?) {
        var icon: String = "skc"
        var percentage: String? = nil
        
        let components = compoundString.components(separatedBy: ",")
        
        for (index, element) in components.enumerated() {
            
            switch index {
            case 0:
                icon = element
            case 1:
                percentage = element
            default:
                print("Error splitting compoundString")
            }
        }
        
        return (icon, percentage)
    }
    
    func assembleIcons(components: [String]) -> JSONIcons {
        
        var jsonIcons = JSONIcons()
        
        for (index, element) in components.enumerated() {
            switch index {
            case 0 ... 2:
                break
                
            case 3:
                jsonIcons.timePeriod = element
                
            case 4:
                let icon1Components = element
                jsonIcons.iconCount = 1
                print("icon1Components: \(icon1Components)")
                
                let parts = split(compoundString: icon1Components)
                jsonIcons.name1 = parts.icon
                
                print("icon1: \(jsonIcons.name1)")
                
                if let percentage = parts.percentage {
                    jsonIcons.chance1 = percentage
                    
                    print("chance_1: \(jsonIcons.chance1!)")
                }
                
            case 5:
                let icon2Components = element
                jsonIcons.iconCount = 2
                print("icon2Components: \(icon2Components)")
                
                let parts2 = split(compoundString: icon2Components)
                jsonIcons.name2 = parts2.icon
                
                print("icon2: \(jsonIcons.name2!)")
                
                if let percentage = parts2.percentage {
                    jsonIcons.chance2 = percentage
                    
                    print("chance_2: \(jsonIcons.chance2!)")
                }
                
            default:
                print("Error assembling icons")
            }
        }
        
        return jsonIcons
    }
    
    func parse(urlString: String) -> IconModel {
        var iconModel = IconModel()
        let met = Meteorology()
        
        let urlWrapped = URL(string: urlString)
        let urlComponents = parse(url: urlWrapped!)
        let jsonIcons = assembleIcons(components: urlComponents)
        
        // print("jsonIcons.iconCount: \(jsonIcons.iconCount)")
        
        iconModel.name = jsonIcons.name1
        var metIcon = met.getIconData(icon: iconModel.name!)
        iconModel.image = metIcon.image
        iconModel.description = metIcon.description
        iconModel.priority = metIcon.priority
        if let chance = jsonIcons.chance1 {
            iconModel.chance = chance + "%"
        }
        
        switch jsonIcons.iconCount {
        case 1:
            return iconModel
        case 2:
            var iconModel2 = IconModel()
            iconModel2.name = jsonIcons.name2
            metIcon = met.getIconData(icon: iconModel2.name!)
            iconModel2.image = metIcon.image
            iconModel2.description = metIcon.description
            iconModel2.priority = metIcon.priority
            
            if let chance2 = jsonIcons.chance2 {
                iconModel2.chance = chance2 + "%"
            }
            
            if iconModel.name == iconModel2.name {
                guard let weatherChance = jsonIcons.chance1 else {
                    return iconModel
                }
                guard let weatherChance2 = jsonIcons.chance2 else {
                    return iconModel2
                }
                let chanceInt = Int(weatherChance)!
                let chanceInt2 = Int(weatherChance2)!
                
                if chanceInt2 > chanceInt {
                    return iconModel2
                } else {
                    return iconModel
                }
            } else {
                if iconModel2.priority > iconModel.priority {
                    return iconModel2
                } else {
                    return iconModel
                }
            }
        default:
            print("icon error!")
        }
       return iconModel
    }
    
    func parse(dateTime: String) -> String {
        let index = dateTime.index(dateTime.startIndex, offsetBy: 10)
        let dateString = dateTime[dateTime.startIndex..<index]
        
        print("dateString: \(dateString)")
        
        let dateComponents = dateString.split(separator: "-")
        print("dateComponents2: \(dateComponents[1])")
        
        let number = String(dateComponents[1])
        let month = monthName(monthNumber: number)
        
        let dayNumber = String(dateComponents[2])
        let date = month + " " + dayNumber
        
        return String(date)
    }
    
    func monthName(monthNumber: String) -> String {
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
    
} // WeatherUtils
