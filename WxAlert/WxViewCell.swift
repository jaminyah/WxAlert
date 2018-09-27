//
//  WxViewCell.swift
//  WxAlert
//
//  Created by macbook on 7/22/18.
//  Copyright © 2018 Jaminya. All rights reserved.
//

import UIKit

class WxViewCell: UICollectionViewCell {
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var alertImage: UIImageView!
    @IBOutlet weak var rainChanceLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var highTempLabel: UILabel!
    @IBOutlet weak var lowTempLabel: UILabel!
    
    func displayWeather(forecast: CellModel ) {
        dayLabel.text = forecast.day
        // weatherImage
        // alertImage
        // rainChanceLabel
        windSpeedLabel.text = forecast.windSpeed
        highTempLabel.text = forecast.hiTemp
        lowTempLabel.text = forecast.lowTemp
    }
}
