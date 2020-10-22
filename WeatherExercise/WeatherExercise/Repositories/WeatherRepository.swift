//
//  WeatherRepository.swift
//  WeatherExercise
//
//  Created by Jawad Ali on 21/10/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

import Foundation
protocol WeatherRepositoryType {
    func getWeatherDetails(latitude:Double, longitude:Double, completion: @escaping(Result<WeatherModel,AppError>)-> Void)
}

class WeatherRepository: WeatherRepositoryType {
    let service: WeatherServiceType = WeatherService()
    
    func getWeatherDetails(latitude:Double, longitude:Double, completion: @escaping(Result<WeatherModel,AppError>)-> Void) {
        service.fetchWeather(for: latitude, longitude: longitude, completion: completion)
    }
}

//class WeatherRepositoryMocked: WeatherRepositoryType {
//    func getWeatherDetails(latitude:Double, longitude:Double, completion: @escaping(Result<WeatherModel,AppError>)-> Void) {
//        completion(.success(WeatherModel.mocked))
//    }
//}
