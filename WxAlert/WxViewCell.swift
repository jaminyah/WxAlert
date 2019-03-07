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
    

    var tapGesture = UITapGestureRecognizer()
    var pages = Pages()
    
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
    }
        
    @objc func onTap(_ sender: UITapGestureRecognizer) -> Void {
        
        // Add activity view?
        let alertViewController = AlertViewController() // Get alert pages array data from Sqlite DB
        // Remove activity view?
        
        self.alertView.backgroundColor = (self.alertView.backgroundColor == UIColor.yellow) ? .green : .yellow
        
        // Push pageviewcontroller via segue
        alertViewController.performSegue(withIdentifier: "pageViewSegue", sender: self)
    }
    
}
