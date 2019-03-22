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

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        eventLabel.text = alertModel.event
        senderLabel.text = alertModel.senderName
        urgencyLabel.text = "Urgency:  " + alertModel.urgency
        severityLabel.text = "Severity: " + alertModel.severity

        let begin = DateUtils.format(dateTime: alertModel.effective)
        beginLabel.text = "Begin: " + begin.mm_dd_yy
        let ends = DateUtils.format(dateTime: alertModel.ends)
        endLabel.text = "Ends:  " + ends.mm_dd_yy
        
        areaLabel.text = alertModel.areaDesc
        headlineLabel.text = alertModel.headline
        instructionLabel.text = alertModel.instruction
        descLabel.text = alertModel.description
        idLabel.text = alertModel.alertId
        
        let tuple = AlertIcon.fetch(imageFor: alertModel.event)
        alertIcon.image = tuple.detailIcon
    }
    
} // class
