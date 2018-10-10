//
//  Icon.swift
//  WxAlert
//
//  Created by macbook on 9/29/18.
//  Copyright © 2018 Jaminya. All rights reserved.
//

import Foundation
import UIKit

class Meteorology {

    init() {}
    
    func getData(icon: String) -> (description: String, image: UIImage) {
        
        var skyCondition: String
        var skyImage: UIImage
        
        switch icon {
        case "skc":
            skyCondition = "Fair/clear"
            skyImage = #imageLiteral(resourceName: "Sun")
        case "few":
            skyCondition = "A few clouds"
            skyImage = #imageLiteral(resourceName: "Sun")
        case "sct":
            skyCondition = "Partly cloudy"
            skyImage = #imageLiteral(resourceName: "PartlySunny")
        case "bkn":
            skyCondition = "Mostly cloudy"
            skyImage = #imageLiteral(resourceName: "Cloud")
        case "ovc":
            skyCondition = "Overcast"
            skyImage = #imageLiteral(resourceName: "Cloud")
        case "wind_skc":
            skyCondition = "Fair/clear and windy"
            skyImage = #imageLiteral(resourceName: "Sun")
        case "wind_few":
            skyCondition = "A few clouds and windy"
            skyImage = #imageLiteral(resourceName: "Sun")
        case "wind_sct":
            skyCondition = "Partly cloudy and windy"
            skyImage = #imageLiteral(resourceName: "PartlySunny")
        case "wind_bkn":
            skyCondition = "Mostly cloudy and windy"
            skyImage = #imageLiteral(resourceName: "Cloud")
        case "wind_ovc":
            skyCondition = "Overcast and windy"
            skyImage = #imageLiteral(resourceName: "Cloud")
        case "snow":
            skyCondition = "Snow"
            skyImage = #imageLiteral(resourceName: "Snow")
        case "rain_snow":
            skyCondition = "Rain/snow"
            skyImage = #imageLiteral(resourceName: "Snow")
        case "rain_sleet":
            skyCondition = "Rain/sleet"
            skyImage = #imageLiteral(resourceName: "Snow")
        case "snow_sleet":
            skyCondition = "Snow/sleet"
            skyImage = #imageLiteral(resourceName: "Snow")
        case "fzra":
            skyCondition = "Freezing rain"
            skyImage = #imageLiteral(resourceName: "Snow")
        case "rain_fzra":
            skyCondition = "Rain/freezing rain"
            skyImage = #imageLiteral(resourceName: "Snow")
        case "snow_fzra":
            skyCondition = "Freezing rain/snow"
            skyImage = #imageLiteral(resourceName: "Snow")
        case "sleet":
            skyCondition = "Sleet"
            skyImage = #imageLiteral(resourceName: "Snow")
        case "rain":
            skyCondition = "Rain"
            skyImage = #imageLiteral(resourceName: "Rain")
        case "rain_showers":
            skyCondition = "Rain showers (high cloud cover)"
            skyImage = #imageLiteral(resourceName: "Rain")
        case "rain_showers_hi":
            skyCondition = "Rain showers (low cloud cover)"
            skyImage = #imageLiteral(resourceName: "Rain")
        case "tsra":
            skyCondition = "Thunderstorm (high cloud cover)"
            skyImage = #imageLiteral(resourceName: "Storm")
        case "tsra_sct":
            skyCondition = "Thunderstorm (medium cloud cover)"
            skyImage = #imageLiteral(resourceName: "Storm")
        case "tsra_hi":
            skyCondition = "Thunderstorm (low cloud cover)"
            skyImage = #imageLiteral(resourceName: "Storm")
        case "tornado":
            skyCondition = "Tornado"
            skyImage = #imageLiteral(resourceName: "Tornado")
        case "hurricane":
            skyCondition = "Hurricane"
            skyImage = #imageLiteral(resourceName: "alert")
        case "tropical_storm":
            skyCondition = "Tropical storm"
            skyImage = #imageLiteral(resourceName: "Storm")
        case "dust":
            skyCondition = "Dust"
            skyImage = #imageLiteral(resourceName: "alert")
        case "smoke":
            skyCondition = "Smoke"
            skyImage = #imageLiteral(resourceName: "alert")
        case "haze":
            skyCondition = "Haze"
            skyImage = #imageLiteral(resourceName: "alert")
        case "hot":
            skyCondition = "Hot"
            skyImage = #imageLiteral(resourceName: "alert")
        case "cold":
            skyCondition = "Cold"
            skyImage = #imageLiteral(resourceName: "alert")
        case "blizzard":
            skyCondition = "Blizzard"
            skyImage = #imageLiteral(resourceName: "alert")
        case "fog":
            skyCondition = "Fog/mist"
            skyImage = #imageLiteral(resourceName: "alert")
        
        default:
            skyCondition = "Partly cloudy"
            skyImage = #imageLiteral(resourceName: "PartlySunny")
        }
        
        return (skyCondition, skyImage)
    }
    
}
