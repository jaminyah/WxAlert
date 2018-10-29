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
            print("N")
            windIcon = #imageLiteral(resourceName: "wind_north")
        case "NE", "NNE", "ENE":
            // print("NE | NNE | ENE")
            windIcon = #imageLiteral(resourceName: "wind_northeast")
        case "NW", "NNW", "WNW":
            // print("NE | NNW | WNW")
            windIcon = #imageLiteral(resourceName: "wind_northwest")
        case "E":
            // print("E")
            windIcon = #imageLiteral(resourceName: "wind_east")
        case "SE", "ESE", "SSE":
            // print("SE | ESE | SSE")
            windIcon = #imageLiteral(resourceName: "wind_southeast")
        case "S":
            // print("S")
            windIcon = #imageLiteral(resourceName: "wind_south")
        case "SW", "SSW", "WSW":
            // print("SW | SSW | WSW")
            windIcon = #imageLiteral(resourceName: "wind_southwest")
        case "W":
            // print("W")
            windIcon = #imageLiteral(resourceName: "wind_west")
        default:
            // print("Set icon to nil")
            windIcon = nil
        }
        
        return windIcon
    }
    
    func trim(day: String) -> String? {
        
        var dayName:String? = nil
        
        switch(day) {
        case "This Afternoon": dayName = "Today"
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
    
    func removeNil(days: [String?]) -> [String] {
        
        var dayList: [String] = []
        var next: String?
        
        for (index, day) in days.enumerated() {
            
            if day == nil {
                next = days[index + 1]
                
                if next == nil {
                    continue
                } else {
                    if let next = next {
                        let previousDay = previous(day: next)
                        dayList.append(previousDay)
                    }
                }
            } else {
                dayList.append(day!)
            }
        } // for
        
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
    
}
