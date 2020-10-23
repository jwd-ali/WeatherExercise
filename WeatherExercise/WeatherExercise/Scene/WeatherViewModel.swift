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
    private var weatherObject: SegregatedWeatherModel?
    
    //MARK:- Initializer
    init(locationHandler: LocationHandler, respostry:WeatherRepositoryType) {
        self.respostry = respostry
        self.locationHandler = locationHandler
        self.locationHandler?.getCurrentLocation {[weak self](location, error) in
            if let locationError = error {
                print(locationError)
                return
            }
            
            if let local = location {
                respostry.getWeatherDetails(latitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!) { [weak self] (result) in
                    self?.parseResponse(result:result)
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
private extension WeatherViewModel {
    func parseResponse(result: Result<WeatherModel,AppError>) {
        switch result {
        case .failure(let error):
            print("error:\(error)")
        case .success( let model):
            self.weatherObject = model
        }
    }
}
