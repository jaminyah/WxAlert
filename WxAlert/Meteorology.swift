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
            rank = Rank.skc.hashValue
        case "few":
            skyCondition = "A few clouds"
            skyImage = #imageLiteral(resourceName: "few")
            rank = Rank.few.hashValue
        case "sct":
            skyCondition = "Partly cloudy"
            skyImage = #imageLiteral(resourceName: "sct")
            rank = Rank.sct.hashValue
        case "bkn":
            skyCondition = "Mostly cloudy"
            skyImage = #imageLiteral(resourceName: "bkn")
            rank = Rank.bkn.hashValue
        case "ovc":
            skyCondition = "Overcast"
            skyImage = #imageLiteral(resourceName: "ovc")
            rank = Rank.ovc.hashValue
        case "wind_skc":
            skyCondition = "Fair/clear and windy"
            skyImage = #imageLiteral(resourceName: "wind_skc")
            rank = Rank.wind_skc.hashValue
        case "wind_few":
            skyCondition = "A few clouds and windy"
            skyImage = #imageLiteral(resourceName: "wind_few")
            rank = Rank.wind_few.hashValue
        case "wind_sct":
            skyCondition = "Partly cloudy and windy"
            skyImage = #imageLiteral(resourceName: "wind_sct")
        case "wind_bkn":
            skyCondition = "Mostly cloudy and windy"
            skyImage = #imageLiteral(resourceName: "wind_bkn")
            rank = Rank.wind_bkn.hashValue
        case "wind_ovc":
            skyCondition = "Overcast and windy"
            skyImage = #imageLiteral(resourceName: "wind_ovc")
            rank = Rank.wind_ovc.hashValue
        case "snow":
            skyCondition = "Snow"
            skyImage = #imageLiteral(resourceName: "snow")
            rank = Rank.snow.hashValue
        case "rain_snow":
            skyCondition = "Rain/snow"
            skyImage = #imageLiteral(resourceName: "rain_snow")
            rank = Rank.rain_snow.hashValue
        case "rain_sleet":
            skyCondition = "Rain/sleet"
            skyImage = #imageLiteral(resourceName: "rain_sleet")
            rank = Rank.rain_sleet.hashValue
        case "snow_sleet":
            skyCondition = "Snow/sleet"
            skyImage = #imageLiteral(resourceName: "snow_sleet")
            rank = Rank.snow_sleet.hashValue
        case "fzra":
            skyCondition = "Freezing rain"
            skyImage = #imageLiteral(resourceName: "fzra")
            rank = Rank.fzra.hashValue
        case "rain_fzra":
            skyCondition = "Rain/freezing rain"
            skyImage = #imageLiteral(resourceName: "fzra")
            rank = Rank.rain_fzra.hashValue
        case "snow_fzra":
            skyCondition = "Freezing rain/snow"
            skyImage =  #imageLiteral(resourceName: "snow_fzra")
            rank = Rank.snow_fzra.hashValue
        case "sleet":
            skyCondition = "Sleet"
            skyImage = #imageLiteral(resourceName: "sleet")
            rank = Rank.sleet.hashValue
        case "rain":
            skyCondition = "Rain"
            skyImage = #imageLiteral(resourceName: "rain")
            rank = Rank.rain.hashValue
        case "rain_showers":
            skyCondition = "Rain showers (high cloud cover)"
            skyImage = #imageLiteral(resourceName: "rain_showers")
            rank = Rank.rain_showers.hashValue
        case "rain_showers_hi":
            skyCondition = "Rain showers (low cloud cover)"
            skyImage = #imageLiteral(resourceName: "rain_showers_hi")
            rank = Rank.rain_showers_hi.hashValue
        case "tsra":
            skyCondition = "Thunderstorm (high cloud cover)"
            skyImage = #imageLiteral(resourceName: "tsra")
            rank = Rank.tsra.hashValue
        case "tsra_sct":
            skyCondition = "Thunderstorm (medium cloud cover)"
            skyImage = #imageLiteral(resourceName: "tsra_sct")
            rank = Rank.tsra_sct.hashValue
        case "tsra_hi":
            skyCondition = "Thunderstorm (low cloud cover)"
            skyImage = #imageLiteral(resourceName: "tsra_hi")
            rank = Rank.tsra_hi.hashValue
        case "tornado":
            skyCondition = "Tornado"
            skyImage = #imageLiteral(resourceName: "alert")
            rank = Rank.tornado.hashValue
        case "hurricane":
            skyCondition = "Hurricane"
            skyImage = #imageLiteral(resourceName: "alert")
            rank = Rank.hurricane.hashValue
        case "tropical_storm":
            skyCondition = "Tropical storm"
            skyImage = #imageLiteral(resourceName: "Storm")
            rank = Rank.tropical_storm.hashValue
        case "dust":
            skyCondition = "Dust"
            skyImage = #imageLiteral(resourceName: "alert")
            rank = Rank.dust.hashValue
        case "smoke":
            skyCondition = "Smoke"
            skyImage = #imageLiteral(resourceName: "alert")
            rank = Rank.smoke.hashValue
        case "haze":
            skyCondition = "Haze"
            skyImage = UIImage(imageLiteralResourceName: "haze")
            rank = Rank.haze.hashValue
        case "hot":
            skyCondition = "Hot"
            skyImage = #imageLiteral(resourceName: "alert")
            rank = Rank.hot.hashValue
        case "cold":
            skyCondition = "Cold"
            skyImage = UIImage(imageLiteralResourceName: "cold")
            rank = Rank.cold.hashValue
        case "blizzard":
            skyCondition = "Blizzard"
            skyImage = #imageLiteral(resourceName: "alert")
            rank = Rank.blizzard.hashValue
        case "fog":
            skyCondition = "Fog/mist"
            skyImage = UIImage(imageLiteralResourceName: "fog")
            rank = Rank.fog.hashValue
        case "alert_cloud":
            skyCondition = "Placeholder"
            skyImage = UIImage(imageLiteralResourceName: "alert_cloud")
        default:
            skyCondition = "Partly cloudy"
            skyImage = #imageLiteral(resourceName: "bkn")
            rank = Rank.bkn.hashValue
        }
        
        return (skyCondition, skyImage, rank)
    }
    
}
