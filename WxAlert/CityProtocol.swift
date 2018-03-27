//
//  CityProtocol.swift
//  WxAlert
//
//  Created by macbook on 3/21/18.
//  Copyright © 2018 Jaminya. All rights reserved.
//

import Foundation

protocol CityProtocol {
    //  func addNewCity(newCityName: String, newStateName: String)
    func addNewCity(city: City)
    func showCities()                                         // Debug only
    func getNameOfCities() -> [String]
    func getCityArray() -> [City]
    func getCityCount() -> Int
    func deleteCity(name: String) -> ()
    //func setNotifications(name: String, newSettings: Notification, position: Int) ->()
    func setNotifications(city: City) ->()

}
