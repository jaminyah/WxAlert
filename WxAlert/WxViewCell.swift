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
    @IBOutlet weak var alertDetail: UIImageView!
    @IBOutlet weak var rainChanceLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var windDirectionLabel: UILabel!
    @IBOutlet weak var windIcon: UIImageView!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var highTempLabel: UILabel!
    @IBOutlet weak var lowTempLabel: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var alertLabel: UILabel!
    @IBOutlet weak var badgeLabel: UILabel!
    
    weak var delegate: GestureProtocol?
    
    func displayWeather(forecast: CellModel, models: [AlertModel]) -> Void {
        
        let tuple = showProperty(inDate: forecast.date, alertModels: models)
        
        dayLabel.text = forecast.day
        weatherImage.image = forecast.wxIcon
        date.text = formatDate(inDate: forecast.date)
        alertLabel.text = tuple.event
        rainChanceLabel.text = forecast.wxChance
        dayNightIcon.image = forecast.dayNightIcon
        windSpeedLabel.text = forecast.windSpeed
        windDirectionLabel.text = forecast.windDirection
        windIcon.image = forecast.windIcon
        highTempLabel.text = forecast.hiTemp
        lowTempLabel.text = forecast.lowTemp
        alertDetail.image = tuple.image
        
        // Badge label
        badgeLabel.clipsToBounds = true
        badgeLabel.layer.cornerRadius = badgeLabel.font.pointSize * 1.2 / 2
        badgeLabel.backgroundColor = .red
        badgeLabel.textColor = .white
        badgeLabel.textAlignment = .center
        badgeLabel.text = String(models.count) + " "
        badgeLabel.isHidden = tuple.isHidden
        
        print(" ")
    }
    
    func addTapGesture() -> Void {
        
        // Tap alert icon to show alert detail
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTap(_:)))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        alertView.addGestureRecognizer(tapGesture)
        alertView.isUserInteractionEnabled = true
    }
    
    @objc func onTap(_ sender: UITapGestureRecognizer) -> Void {
        
        delegate?.performAlertViewSegue()
    }
    
    func showProperty(inDate: String, alertModels: [AlertModel]) -> (image: UIImage?, event: String?, isHidden: Bool) {
        
        var detailTuple: (image: UIImage?, event: String?, isHidden: Bool) = (image: nil, event: nil, isHidden: true)
        
        let rfcCellDate = DateUtils.rfc3339Formatter(date: inDate)
        let systemClock = DateUtils.nowDateString()
        let rfcSystemDate = DateUtils.rfc3339Formatter(date: systemClock)
        let calendar = Calendar(identifier: .iso8601)
        let cellDateComponents = calendar.dateComponents([.year,.month, .day], from: rfcCellDate)
        let systemDateComponents = calendar.dateComponents([.year, .month, .day], from: rfcSystemDate)
        let cellDay = cellDateComponents.day
        let systemDay = systemDateComponents.day
        
        if alertModels.count == 0 {
            // Debug
            print("alertModels.count: \(alertModels.count)")
            detailTuple = (image: nil, event: nil, isHidden: true)
            alertView.isUserInteractionEnabled = false
        } else if alertModels[0].ends == "" && alertModels[0].event == "Flood Warning" {
            print("alertModels[0].end = null")
            let iconTuple = AlertIcon.fetch(imageFor: alertModels[0].event)
            let alertImage = iconTuple.detailIcon
            detailTuple = (image: alertImage, event: alertModels[0].event, isHidden: false)
            addTapGesture()
        } else if cellDay == systemDay {
            print("cellDay == systemDay")
            let rfcAlertEndsDate = DateUtils.rfc3339Formatter(date: alertModels[0].ends)
            let rfcAlertEffectiveDate = DateUtils.rfc3339Formatter(date: alertModels[0].effective)
            
            if rfcSystemDate >= rfcAlertEffectiveDate && rfcSystemDate <= rfcAlertEndsDate {
                
                let iconTuple = AlertIcon.fetch(imageFor: alertModels[0].event)
                let alertImage = iconTuple.detailIcon
                detailTuple = (image: alertImage, event: alertModels[0].event, isHidden: false)
                addTapGesture()
            }
        } else {
            // Severe TStorm alerts can include ends = null
            var rfcAlertEndsDate = DateUtils.rfc3339Formatter(date: alertModels[0].ends)
            let rfcAlertEffectiveDate = DateUtils.rfc3339Formatter(date: alertModels[0].effective)
            
            if alertModels[0].ends == "" {
                rfcAlertEndsDate = DateUtils.rfc3339Formatter(date: alertModels[0].expires)
            } else {
                rfcAlertEndsDate = DateUtils.rfc3339Formatter(date: alertModels[0].ends)
            }
            
            let cellDate = rfcCellDate
            let alertEffectiveDate = rfcAlertEffectiveDate
            let alertEndsDate = rfcAlertEndsDate
            
            if cellDate >= alertEffectiveDate && cellDate <= alertEndsDate {
                print("cellDate >= alertEffectiveDate ...")
                let iconTuple = AlertIcon.fetch(imageFor: alertModels[0].event)
                let alertImage = iconTuple.detailIcon
                detailTuple = (image: alertImage, event: alertModels[0].event, isHidden: false)
                addTapGesture()
            } else {
                detailTuple = (image: nil, event: nil, isHidden: true)
                alertView.isUserInteractionEnabled = false
            }
            
            // Debug
            print("cellDate: \(cellDate)")
            print("alertEffectiveDate: \(alertEffectiveDate)")
            print("alertEndsDate: \(alertEndsDate)")
        }

        return detailTuple
    }
    
    func formatDate(inDate: String) -> String {
        
        let formatter = DateUtils.format(dateTime: inDate)
        let outDate = formatter.mm_dd
        return outDate
    }
    
} // WxViewCell
