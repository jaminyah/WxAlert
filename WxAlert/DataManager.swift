//
//  DataManager.swift
//  WxAlert
//
//  Created by macbook on 3/21/18.
//  Copyright © 2018 Jaminya. All rights reserved.
//

import Foundation

final class DataManager {

    // Thread Safe?
    static let sharedInstance = DataManager()
    private init(){}

    private var cityArray = [City]()

    func  appendCityObject(newCity: City) -> () {
    
        // TODO - add completion handler or Boolean to return success or failure
        let city = City(name: newCity.cityName, state: newCity.region.state, coordinates: newCity.coordinates)
    
        if cityArray.index(where: {($0.cityName == newCity.cityName) && ($0.region.state == newCity.region.state)}) == nil {
        self.cityArray.append(city)
    }
}


func removeCity(cityName: String) -> () {
    if let index = cityArray.index(where: { $0.cityName == cityName}) {
        self.cityArray.remove(at: index)
    }
}

func cityCount() -> (Int) {
    print("cityCount: \(self.cityArray.count)")
    return self.cityArray.count
}

// Debug only
func showCities() -> () {
    for city in cityArray {
        print("City name: " + city.cityName + ", " + city.region.state)
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
    let emptyCity = City()
    
    if let index = cityArray.index(where: { $0.cityName == cityName}) {
        return self.cityArray[index]
    }
    return emptyCity
}
    
func getCityArray() -> [City] {
    
    return cityArray
}

    func updateNotifications(cityObject: City) {
        
       // var cityItem: City
        if let position = cityArray.index(where: { $0.cityName == cityObject.cityName}) {
            self.cityArray[position] = cityObject
        }
    
    // Modify array item at this position
    //cityObject.notificationList[index] = settings
    
    // Add new array item back at same position
    //self.cityArray[position!] = cityObject
    }
    
}
