//
//  AlertViewController.swift
//  WxAlert
//
//  Created by macbook on 3/7/19.
//  Copyright © 2019 Jaminya. All rights reserved.
//
/* Purpose: Transitions to the page view controller. */

import UIKit

class AlertViewController: UIViewController {

    var pages = Pages()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destinationVC = segue.destination as? PageViewController {
            destinationVC.pages.array = pages.array
        }
    }
}
