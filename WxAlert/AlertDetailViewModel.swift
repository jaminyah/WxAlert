//
//  AlertDetailViewModel.swift
//  WxAlert
//
//  Created by macbook on 3/9/19.
//  Copyright © 2019 Jaminya. All rights reserved.
//

import Foundation
import UIKit

struct AlertDetailViewModel {
    
    var alertIcon: UIImage = UIImage(imageLiteralResourceName: "placeholder_alert_detail")
    var event: String = "Lorem ipsum ..."
    var sender: String = "Lorem ipsum ..."
    var begin: String = UNIX_EPOCH_DATE
    var end: String = UNIX_EPOCH_DATE
    var urgency: String = "Lorem ipsum ..."
    var severity: String = "Lorem ipsum ..."
    var area: String = "Lorem ipsum ..."
    var headline: String = "Lorem ipsum ..."
    var instruction: String = "Lorem ipsum ..."
    var desc: String = "Lorem ipsum ..."
    var id: String = "NWS-IDP-PROD-XXXXXX-XXXXXXX"
}
