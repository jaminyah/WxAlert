//
//  CellViewModel.swift
//  WxAlert
//
//  Created by macbook on 2/7/19.
//  Copyright © 2019 Jaminya. All rights reserved.
//

import Foundation

class CellViewModel {
    
    let dbmgr = DbMgr.sharedInstance
    //var table: String = ""
    
    let rootController = RootController.sharedInstance
    var delegate: CityProtocol? = nil
    
    init() {
        delegate = rootController
    }
}
