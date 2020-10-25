//
//  DailyTableViewCellViewModel.swift
//  WeatherExercise
//
//  Created by Jawad Ali on 23/10/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

import Foundation
protocol DailyTableViewCellViewModelType {
    var timeBinder: Binder<String>{ get }
    var iconBinder: Binder<String>{ get }
    var maxTempretureBinder: Binder<String>{ get }
    var minTempretureBinder: Binder<String>{ get }
    
}
class DailyTableViewCellViewModel: DailyTableViewCellViewModelType, WeatherCellItem {
    
    //MARK:- Properties
    private let dailyData: SegregatedDatum
    
    var timeBinder = Binder("")
    var iconBinder = Binder("")
    var maxTempretureBinder = Binder("")
    var minTempretureBinder = Binder("")
    
    var type: WeatherCellItemType = .dailyCell
    
    init(with daily:Datum) {
        self.dailyData = daily
        bindValues()
    }
}
private extension DailyTableViewCellViewModel {
    func bindValues() {
        minTempretureBinder.value = ("\(dailyData.temperatureLow?.convertFahrenheitToCelsius() ?? 0)°")
        maxTempretureBinder.value = ("\(dailyData.temperatureHigh?.convertFahrenheitToCelsius() ?? 0)°")
        iconBinder.value = dailyData.icon?.rawValue ?? ""
        timeBinder.value = dailyData.time?.daySting() ?? ""
    }
    
}
