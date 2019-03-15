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
    
    var alertModel: AlertModel
        
    init(alertModel: AlertModel) {        
        self.alertModel = alertModel
    }
    
    func createViewController() -> UIViewController? {
        
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "alertDetailVC") as? AlertDetailViewController
        viewController?.alertModel = alertModel
        
        return viewController
    }
}
