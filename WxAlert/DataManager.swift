//
//  DataManager.swift
//  WxAlert
//
//  Created by macbook on 3/21/18.
//  Copyright © 2018 Jaminya. All rights reserved.
//

import Foundation

final class DataManager{

static let sharedInstance = DataManager()
private init(){}

private var city = City()
private var cityArray = [City]()

func  appendCityObject(newCity: City) -> () {
    
    self.city = newCity
    self.cityArray.append(self.city)
}


func removeCity(cityName: String) -> () {
    if let index = cityArray.index(where: { $0.cityName == cityName}) {
        self.cityArray.remove(at: index)
    }
}

func cityCount() -> (Int) {
    print("cityCount: self.cityArray.count")
    return self.cityArray.count
}

// Debug only
func showCities() -> () {
    for city in cityArray {
        print("City name: \(city.cityName)")
    }
}

func getCityNames() -> ([String]) {
    var names = [String]()
    
    for city in self.cityArray {
        names.append(city.cityName)
    }
    return names
}

func getCityObject(cityName: String) -> City {
    let index = cityArray.index(where: { $0.cityName == cityName}) //{
    return self.cityArray[index!]
}

func updateNotifications(cityName: String, settings: Notification, index: Int) {
    let position = cityArray.index(where: { $0.cityName == cityName})
    var cityObject = self.cityArray[position!]
    
    // Modify array item at this position
    cityObject.notificationList[index] = settings
    
    // Add new array item back at same position
    self.cityArray[position!] = cityObject
}
}
