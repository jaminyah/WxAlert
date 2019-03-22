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
    
    var tapGesture = UITapGestureRecognizer()
    weak var delegate: GestureProtocol?
    
    func displayWeather(forecast: CellModel) -> Void {
        
        let alertViewModel = AlertViewModel()
        let models = alertViewModel.fetchAlerts()
        
        dayLabel.text = forecast.day
        weatherImage.image = forecast.wxIcon
        date.text = formatDate(inDate: forecast.date)
        alertLabel.text = showIconEvent(inDate: forecast.date, alertModels: models).event
        rainChanceLabel.text = forecast.wxChance
        dayNightIcon.image = forecast.dayNightIcon
        windSpeedLabel.text = forecast.windSpeed
        windDirectionLabel.text = forecast.windDirection
        windIcon.image = forecast.windIcon
        highTempLabel.text = forecast.hiTemp
        lowTempLabel.text = forecast.lowTemp
        alertDetail.image = showIconEvent(inDate: forecast.date, alertModels: models).image
        
        addTapGesture()
    }
    
    func addTapGesture() -> Void {
        
        // Tap alert icon to show alert detail
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTap(_:)))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        alertView.addGestureRecognizer(tapGesture)
        alertView.isUserInteractionEnabled = true
    }
    
    @objc func onTap(_ sender: UITapGestureRecognizer) -> Void {
        
        delegate?.performAlertViewSegue()
    }
    
    func showIconEvent(inDate: String, alertModels: [AlertModel]) -> (image: UIImage?, event: String?) {
        
        var detailTuple: (image: UIImage?, event: String?) = (image: nil, event: nil)
        let event: String? = alertModels[0].event
        
        if event == nil { return detailTuple }
        
        // Example inDate: 2019-03-22T23:43:09-06:00
        let rfc3339Formater = DateFormatter()
        rfc3339Formater.locale = Locale(identifier: "en_US_POSIX")
        rfc3339Formater.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        rfc3339Formater.timeZone = TimeZone(secondsFromGMT: 0)

        let date = inDate
        let rfcCellDate = rfc3339Formater.date(from: date)
        
        let effectiveDate = alertModels[0].effective
        let rfcAlertEffectiveDate = rfc3339Formater.date(from: effectiveDate)
        
        let endsDate = alertModels[0].ends
        let rfcAlertEndsDate = rfc3339Formater.date(from: endsDate)
        
        guard let cellDate = rfcCellDate else { return (image: nil, event: nil) }
        guard let alertEffectiveDate = rfcAlertEffectiveDate else { return (image: nil, event: nil) }
        guard let alertEndsDate = rfcAlertEndsDate else { return (image: nil, event: nil) }
        
        if cellDate >= alertEffectiveDate && cellDate <= alertEndsDate {
            let iconTuple = AlertIcon.fetch(imageFor: alertModels[0].event)
            let alertImage = iconTuple.detailIcon
            let alertEvent = alertModels[0].event
            detailTuple = (image: alertImage, event: alertEvent)
        }
        return detailTuple
    }

    
    func formatDate(inDate: String) -> String {
        
        let formatter = DateUtils.format(dateTime: inDate)
        let outDate = formatter.mm_dd
        return outDate
    }
    
} // WxViewCell
