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
    @IBOutlet weak var dayNightIcon: UIImageView!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var alert: UIImageView!
    
    @IBOutlet weak var rainChanceLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var windDirectionLabel: UILabel!
    @IBOutlet weak var windIcon: UIImageView!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var highTempLabel: UILabel!
    @IBOutlet weak var lowTempLabel: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var alertLabel: UILabel!
    
    //var icons:[UIImage]? = []
    //var timer = Timer()
    var tapGesture = UITapGestureRecognizer()
    
    func displayWeather(forecast: CellModel) -> Void {
        dayLabel.text = forecast.day
        weatherImage.image = forecast.wxIcon
        date.text = forecast.date
        alertLabel.text = forecast.alertLbl
        rainChanceLabel.text = forecast.wxChance
        dayNightIcon.image = forecast.dayNightIcon
        windSpeedLabel.text = forecast.windSpeed
        windDirectionLabel.text = forecast.windDirection
        windIcon.image = forecast.windIcon
        highTempLabel.text = forecast.hiTemp
        lowTempLabel.text = forecast.lowTemp
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTap(_:)))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        alertView.addGestureRecognizer(tapGesture)
        alertView.isUserInteractionEnabled = true
        
       // alert.image = forecast.alertIcon
        /*
        alert.image = forecast.alertIcons?.first
        icons = forecast.alertIcons
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(onSlider), userInfo: nil, repeats: true)
        */
    }
    
    /*
    @objc func onSlider() -> Void {
        var imageCount = 0
        let alertCount = icons?.count ?? 0
        if (imageCount < alertCount) {
            imageCount = imageCount + 1
        } else {
            imageCount = 0
        }
        
        UIView.transition(with: self.alert, duration: 2.0, options: .transitionCrossDissolve, animations: {self.alert.image = self.icons?[imageCount]}, completion: nil)
    }
    */
    
    @objc func onTap(_ sender: UITapGestureRecognizer) -> Void {
        
        self.alertView.backgroundColor = (self.alertView.backgroundColor == UIColor.yellow) ? .green : .yellow
    }
}
