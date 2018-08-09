//
//  CityProtocol.swift
//  WxAlert
//
//  Created by macbook on 3/21/18.
//  Copyright © 2018 Jaminya. All rights reserved.
//

import Foundation

protocol CityProtocol {
    func addNewCity(city: City)
    func showCities()                                         // Debug only
    func getNameOfCities() -> [String]
    func getCityArray() -> [City]
    func getCityCount() -> Int
    func deleteCity(name: String) -> ()
    func setNotifications(city: City) ->()
    func setSelectedCity(name: String, index: Int) ->()
    func selectedCity() -> SelectedCity
    func setTimeFrame(timeFrame: TimeFrame) -> ()
}
