//
//  WeatherViewModel.swift
//  WeatherExercise
//
//  Created by Jawad Ali on 22/10/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

import Foundation
protocol WeatherViewModelType {
}

class WeatherViewModel: WeatherViewModelType {
    
    //MARK:- Propeerties
    private var respostry: WeatherRepositoryType
    private var locationHandler: LocationHandler?
    
    //MARK:- Initializer
    init(locationHandler: LocationHandler, respostry:WeatherRepositoryType) {
        self.respostry = respostry
        self.locationHandler = locationHandler
        self.locationHandler?.getCurrentLocation {[weak self](location, error) in
            //print("Jawad print location:\(location), city::")
            
            if let local = location {
                respostry.getWeatherDetails(latitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!) { (result) in
                                   print(result)
                               }
            self?.locationHandler?.fetchCityAndCountry(from: local, completion: { (city, country, error) in
                print("city:\(city ?? "")")

            })
            
            }
        }
    }
    
    init(latitude:Double, longitude:Double, respostry:WeatherRepositoryType) {
        self.respostry = respostry
    }
    
}
