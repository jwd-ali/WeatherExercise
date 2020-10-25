//
//  HourlyCollectionViewCellViewModel.swift
//  WeatherExercise
//
//  Created by Jawad Ali on 23/10/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

import Foundation
protocol HourlyCollectionViewCellViewModelType {
    var timeBinder: Binder<String>{ get }
    var iconBinder: Binder<String>{ get }
    var tempretureBinder: Binder<String>{ get }
}
class HourlyCollectionViewCellViewModel: HourlyCollectionViewCellViewModelType {
    
    //MARK:- Properties
    private let hourlyData : SegregatedCurrently
    var timeBinder = Binder("")
    var iconBinder = Binder("")
    var tempretureBinder = Binder("")
    
    init(with hourly:Currently) {
        self.hourlyData = hourly
        bindValues()
    }
}
private extension HourlyCollectionViewCellViewModel {
    func bindValues() {
        tempretureBinder.value = ("\(hourlyData.temperature?.convertFahrenheitToCelsius() ?? 0)°")
        iconBinder.value = hourlyData.icon?.rawValue ?? ""
        timeBinder.value = hourlyData.time?.twentyfourHours() ?? ""
    }
}
