//
//  AlertViewCell.swift
//  WxAlert
//
//  Created by macbook on 2/10/19.
//  Copyright © 2019 Jaminya. All rights reserved.
//

import UIKit

class AlertViewCell: UICollectionViewCell {
  
    @IBOutlet weak var alertView: UIImageView!
    
    func displayAlert(model: AlertModel) -> Void {
       // let event = model.event
        //alertView.image = AlertIcon().fetch(imageFor: event)
        alertView.image = UIImage(imageLiteralResourceName: "fire_alert")
    }
}
