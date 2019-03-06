//
//  AlertDetailViewController.swift
//  WxAlert
//
//  Created by macbook on 2/20/19.
//  Copyright © 2019 Jaminya. All rights reserved.
//

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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
