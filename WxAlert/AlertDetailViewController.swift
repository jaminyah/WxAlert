//
//  AlertDetailViewController.swift
//  WxAlert
//
//  Created by macbook on 2/20/19.
//  Copyright © 2019 Jaminya. All rights reserved.
//
/**
 Purpose: Controls the layout of the alert detail view page.
 **/

import UIKit

class AlertDetailViewController: UIViewController {

    @IBOutlet weak var alertIcon: UIImageView!
    @IBOutlet weak var eventLabel: UILabel!
    @IBOutlet weak var senderLabel: UILabel!
    @IBOutlet weak var beginLabel: UILabel!
    @IBOutlet weak var endLabel: UILabel!
    @IBOutlet weak var urgencyLabel: UILabel!
    @IBOutlet weak var severityLabel: UILabel!
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    
    var alertModel = AlertModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        eventLabel.text = alertModel.event
        senderLabel.text = alertModel.senderName
        urgencyLabel.text = alertModel.urgency
        severityLabel.text = alertModel.severity
        beginLabel.text = alertModel.effective
        endLabel.text = alertModel.ends
        areaLabel.text = alertModel.areaDesc
        headlineLabel.text = alertModel.headline
        instructionLabel.text = alertModel.instruction
        descLabel.text = alertModel.description
        idLabel.text = alertModel.alertId
        
        let tuple = AlertIcon.fetch(imageFor: alertModel.event)
        alertIcon.image = tuple.detailIcon
    }
    
}
