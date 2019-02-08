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
    
    let rootController = RootController.sharedInstance
    var delegate: CityProtocol? = nil
    var tableName: String
    var selectedCity = SelectedCity()
    
    init() {
        delegate = rootController
        if let selected = delegate?.getSelectedCity() {
                self.selectedCity = selected
        }
        self.tableName = selectedCity.name.replacingOccurrences(of: " ", with: "_") + "_" + selectedCity.state
    }
}
