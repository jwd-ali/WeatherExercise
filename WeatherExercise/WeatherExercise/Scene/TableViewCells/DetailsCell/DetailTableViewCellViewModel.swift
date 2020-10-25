//
//  DetailTableViewCellViewModel.swift
//  WeatherExercise
//
//  Created by Jawad Ali on 24/10/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

import Foundation
import Foundation
protocol DetailTableViewCellViewModelType {
    var sunriseBinder: Binder<String>{ get }
    var sunsetBinder: Binder<String>{ get }
    var chanceOfRainBinder: Binder<String>{ get }
    var humidityBinder: Binder<String>{ get }
    var windBinder: Binder<String>{ get }
    var pressureBinder: Binder<String>{ get }
    var visibilityBinder: Binder<String>{ get }
    var uvIndexBinder: Binder<String>{ get }
  
    
}
class DetailTableViewCellViewModel: DetailTableViewCellViewModelType, WeatherCellItem {
    
    //MARK:- Properties
    private let details: SegregatedDetails
    
    //MARK:- Binders
    var sunriseBinder = Binder("")
    var sunsetBinder = Binder("")
    var chanceOfRainBinder = Binder("")
    var humidityBinder = Binder("")
    var windBinder = Binder("")
    var pressureBinder = Binder("")
    var visibilityBinder = Binder("")
    var uvIndexBinder = Binder("")
    
    var type: WeatherCellItemType = .detailCell
    
    init(with details:SegregatedDetails) {
        self.details = details
        bindValues()
    }
}
private extension DetailTableViewCellViewModel {
    func bindValues() {
        if let sunsetTime = details.sunsetTime { sunsetBinder.value = ("Sunset: \(sunsetTime.twelveHours())") }
        if let sunriseTime = details.sunriseTime { sunriseBinder.value = ("Sunrise: \(sunriseTime.twelveHours())") }
        if let rainChance = details.precipProbability { chanceOfRainBinder.value = ("Chance of Rain: \(String(rainChance))%") }
        if let humidity = details.humidity { humidityBinder.value = ("Humidity: \(String(humidity))%") }
        if let wind = details.windSpeed { windBinder.value = ("Wind: \(String(wind)) km/h") }
        if let pressure = details.pressure { pressureBinder.value = ("Pressure: \(String(pressure)) hPa") }
        if let visibility = details.visibility { visibilityBinder.value = ("Visibility: \(String(visibility)) km") }
        if let uvIndex = details.uvIndex { uvIndexBinder.value = ("uvIndex: \(String(uvIndex))") }
    }
    
}
