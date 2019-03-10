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
        let event = model.event
        let tuple = AlertIcon().fetch(imageFor: event)
        alertView.image = tuple.icon
    }
}
