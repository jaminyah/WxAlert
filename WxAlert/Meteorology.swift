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
    
    func getIconData(icon: String) -> (description: String, image: UIImage, priority: Int) {
        
        var skyCondition: String
        var skyImage: UIImage
        var rank: Int = -1
        
        switch icon {
        case "skc":
            skyCondition = "Fair/clear"
            skyImage = UIImage(imageLiteralResourceName: "skc")
            rank = Rank.skc.rawValue
        case "few":
            skyCondition = "A few clouds"
            skyImage = #imageLiteral(resourceName: "few")
            rank = Rank.few.rawValue
        case "sct":
            skyCondition = "Partly cloudy"
            skyImage = #imageLiteral(resourceName: "sct")
            rank = Rank.sct.rawValue
        case "bkn":
            skyCondition = "Mostly cloudy"
            skyImage = #imageLiteral(resourceName: "bkn")
            rank = Rank.bkn.rawValue
        case "ovc":
            skyCondition = "Overcast"
            skyImage = #imageLiteral(resourceName: "ovc")
            rank = Rank.ovc.rawValue
        case "wind_skc":
            skyCondition = "Fair/clear and windy"
            skyImage = #imageLiteral(resourceName: "wind_skc")
            rank = Rank.wind_skc.rawValue
        case "wind_few":
            skyCondition = "A few clouds and windy"
            skyImage = #imageLiteral(resourceName: "wind_few")
            rank = Rank.wind_few.rawValue
        case "wind_sct":
            skyCondition = "Partly cloudy and windy"
            skyImage = #imageLiteral(resourceName: "wind_sct")
        case "wind_bkn":
            skyCondition = "Mostly cloudy and windy"
            skyImage = #imageLiteral(resourceName: "wind_bkn")
            rank = Rank.wind_bkn.rawValue
        case "wind_ovc":
            skyCondition = "Overcast and windy"
            skyImage = #imageLiteral(resourceName: "wind_ovc")
            rank = Rank.wind_ovc.rawValue
        case "snow":
            skyCondition = "Snow"
            skyImage = UIImage(imageLiteralResourceName: "snow")
            rank = Rank.snow.rawValue
        case "rain_snow":
            skyCondition = "Rain/snow"
            skyImage = #imageLiteral(resourceName: "rain_snow")
            rank = Rank.rain_snow.rawValue
        case "rain_sleet":
            skyCondition = "Rain/sleet"
            skyImage = #imageLiteral(resourceName: "rain_sleet")
            rank = Rank.rain_sleet.rawValue
        case "snow_sleet":
            skyCondition = "Snow/sleet"
            skyImage = #imageLiteral(resourceName: "snow_sleet")
            rank = Rank.snow_sleet.rawValue
        case "fzra":
            skyCondition = "Freezing rain"
            skyImage = #imageLiteral(resourceName: "fzra")
            rank = Rank.fzra.rawValue
        case "rain_fzra":
            skyCondition = "Rain/freezing rain"
            skyImage = #imageLiteral(resourceName: "fzra")
            rank = Rank.rain_fzra.rawValue
        case "snow_fzra":
            skyCondition = "Freezing rain/snow"
            skyImage =  #imageLiteral(resourceName: "snow_fzra")
            rank = Rank.snow_fzra.rawValue
        case "sleet":
            skyCondition = "Sleet"
            skyImage = #imageLiteral(resourceName: "sleet")
            rank = Rank.sleet.rawValue
        case "rain":
            skyCondition = "Rain"
            skyImage = #imageLiteral(resourceName: "rain")
            rank = Rank.rain.rawValue
        case "rain_showers":
            skyCondition = "Rain showers (high cloud cover)"
            skyImage = #imageLiteral(resourceName: "rain_showers")
            rank = Rank.rain_showers.rawValue
        case "rain_showers_hi":
            skyCondition = "Rain showers (low cloud cover)"
            skyImage = #imageLiteral(resourceName: "rain_showers_hi")
            rank = Rank.rain_showers_hi.rawValue
        case "tsra":
            skyCondition = "Thunderstorm (high cloud cover)"
            skyImage = #imageLiteral(resourceName: "tsra")
            rank = Rank.tsra.rawValue
        case "tsra_sct":
            skyCondition = "Thunderstorm (medium cloud cover)"
            skyImage = #imageLiteral(resourceName: "tsra_sct")
            rank = Rank.tsra_sct.rawValue
        case "tsra_hi":
            skyCondition = "Thunderstorm (low cloud cover)"
            skyImage = #imageLiteral(resourceName: "tsra_hi")
            rank = Rank.tsra_hi.rawValue
        case "tornado":
            skyCondition = "Tornado"
            skyImage = #imageLiteral(resourceName: "alert")
            rank = Rank.tornado.rawValue
        case "hurricane":
            skyCondition = "Hurricane"
            skyImage = #imageLiteral(resourceName: "alert")
            rank = Rank.hurricane.rawValue
        case "tropical_storm":
            skyCondition = "Tropical storm"
            skyImage = #imageLiteral(resourceName: "Storm")
            rank = Rank.tropical_storm.rawValue
        case "dust":
            skyCondition = "Dust"
            skyImage = #imageLiteral(resourceName: "alert")
            rank = Rank.dust.rawValue
        case "smoke":
            skyCondition = "Smoke"
            skyImage = UIImage(imageLiteralResourceName: "smoke")
            rank = Rank.smoke.rawValue
        case "haze":
            skyCondition = "Haze"
            skyImage = UIImage(imageLiteralResourceName: "haze")
            rank = Rank.haze.rawValue
        case "hot":
            skyCondition = "Hot"
            skyImage = #imageLiteral(resourceName: "alert")
            rank = Rank.hot.rawValue
        case "cold":
            skyCondition = "Cold"
            skyImage = UIImage(imageLiteralResourceName: "cold")
            rank = Rank.cold.rawValue
        case "blizzard":
            skyCondition = "Blizzard"
            skyImage = UIImage(imageLiteralResourceName: "blizzard")
            rank = Rank.blizzard.rawValue
        case "fog":
            skyCondition = "Fog/mist"
            skyImage = UIImage(imageLiteralResourceName: "fog")
            rank = Rank.fog.rawValue
        case "alert_cloud":
            skyCondition = "Placeholder"
            skyImage = UIImage(imageLiteralResourceName: "alert_cloud")
        default:
            skyCondition = "Partly cloudy"
            skyImage = #imageLiteral(resourceName: "bkn")
            rank = Rank.bkn.rawValue
        }
        
        return (skyCondition, skyImage, rank)
    }
    
}
