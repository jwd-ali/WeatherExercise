//
//  HourlyCollectionViewCellViewModel.swift
//  WeatherExercise
//
//  Created by Jawad Ali on 23/10/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

import Foundation
protocol HourlyCollectionViewCellViewModelType {
    func numberOfItems()-> Int
}
class HourlyCollectionViewCellViewModel: HourlyCollectionViewCellViewModelType {

//MARK:- Properties
    private let hourlyData : Hourly
       
       init(with hourly:Hourly) {
           self.hourlyData = hourly
       }
}
extension HourlyCollectionViewCellViewModel {
    func numberOfItems()-> Int {
        hourlyData.data?.count ?? 0
    }
}
