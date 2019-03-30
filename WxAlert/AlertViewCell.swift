//
//  AlertViewCell.swift
//  WxAlert
//
//  Created by macbook on 2/10/19.
//  Copyright © 2019 Jaminya. All rights reserved.
//

import UIKit

class AlertViewCell: UICollectionViewCell {
  
    @IBOutlet weak var alertImageView: UIImageView!
    
    func displayAlert(model: AlertModel) -> Void {
        
        let tuple = AlertIcon.fetch(imageFor: model.event)
        alertImageView.image = tuple.icon
    }
}
