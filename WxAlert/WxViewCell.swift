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
                
        dayLabel.text = forecast.day
        weatherImage.image = forecast.wxIcon
        date.text = formatDate(inDate: forecast.date)
        alertLabel.text = showProperty(inDate: forecast.date, alertModels: models).event
        rainChanceLabel.text = forecast.wxChance
        dayNightIcon.image = forecast.dayNightIcon
        windSpeedLabel.text = forecast.windSpeed
        windDirectionLabel.text = forecast.windDirection
        windIcon.image = forecast.windIcon
        highTempLabel.text = forecast.hiTemp
        lowTempLabel.text = forecast.lowTemp
        alertDetail.image = showProperty(inDate: forecast.date, alertModels: models).image
        
        // Badge label
        badgeLabel.clipsToBounds = true
        badgeLabel.layer.cornerRadius = badgeLabel.font.pointSize * 1.2 / 2
        badgeLabel.backgroundColor = .red
        badgeLabel.textColor = .white
        badgeLabel.textAlignment = .center
        badgeLabel.text = String(models.count) + " "
        badgeLabel.isHidden = showProperty(inDate: forecast.date, alertModels: models).isHidden
        
        addTapGesture()
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
        
        var detailTuple: (image: UIImage?, event: String?, isHidden: Bool)
        var rfcAlertEndsDate: Date? = nil
         
        if alertModels.count == 0 {
            detailTuple = (image: nil, event: nil, isHidden: true)
        } else if alertModels[0].ends == "" && alertModels[0].event == "Flood Warning" {
            let iconTuple = AlertIcon.fetch(imageFor: alertModels[0].event)
            let alertImage = iconTuple.detailIcon
            detailTuple = (image: alertImage, event: alertModels[0].event, isHidden: false)
        } else {
            // Example inDate: 2019-03-22T23:43:09-06:00
            let rfc3339Formater = DateFormatter()
            rfc3339Formater.locale = Locale(identifier: "en_US_POSIX")
            rfc3339Formater.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
            rfc3339Formater.timeZone = TimeZone.init(secondsFromGMT: 0)
            
            let rfcCellDate = rfc3339Formater.date(from: inDate)
            let rfcAlertEffectiveDate = rfc3339Formater.date(from: alertModels[0].effective)
            
            // Severe TStorm alerts can include ends = null
            if alertModels[0].ends == "" {
                rfcAlertEndsDate = rfc3339Formater.date(from: alertModels[0].expires)
            } else {
                rfcAlertEndsDate = rfc3339Formater.date(from: alertModels[0].ends)
            }
            
            guard let cellDate = rfcCellDate else { return (image: nil, event: nil, isHidden: true) }
            guard let alertEffectiveDate = rfcAlertEffectiveDate else { return (image: nil, event: nil, isHidden: true) }
            guard let alertEndsDate = rfcAlertEndsDate else { return (image: nil, event: nil, isHidden: true) }
                        
            if cellDate >= alertEffectiveDate && cellDate <= alertEndsDate {
                let iconTuple = AlertIcon.fetch(imageFor: alertModels[0].event)
                let alertImage = iconTuple.detailIcon
                detailTuple = (image: alertImage, event: alertModels[0].event, isHidden: false)
            } else {
                detailTuple = (image: nil, event: nil, isHidden: true)
            }
        }
 
        return detailTuple
    }
    
    func formatDate(inDate: String) -> String {
        
        let formatter = DateUtils.format(dateTime: inDate)
        let outDate = formatter.mm_dd
        return outDate
    }
    
} // WxViewCell
