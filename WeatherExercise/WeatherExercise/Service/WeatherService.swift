//
//  WeatherService.swift
//  WeatherExercise
//
//  Created by Jawad Ali on 20/10/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

import Foundation

protocol WeatherServiceType {
    func fetchWeather(for latitude:Double, longitude:Double, completion: @escaping(Result<WeatherModel,AppError>) -> Void)
}

class WeatherService: WeatherServiceType {
    private let apiConvertible:ApiService = APIClient()
    
    func fetchWeather(for latitude:Double, longitude:Double, completion: @escaping(Result<WeatherModel,AppError>) -> Void) {
        
        let request = WeatherServiceRequest(latitude: latitude, longitude: longitude)
        let router = WeatherNetworkRouter.getWeather(request)
        apiConvertible.performRequest(router: router) { (result:Result<WeatherModel, AppError>) in
            
            switch result{
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                completion(.success(data))
                
            }
        }
    }
}
