//
//  DailyTableViewCellViewModel.swift
//  WeatherExercise
//
//  Created by Jawad Ali on 23/10/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

import Foundation
import Foundation
protocol DailyTableViewCellViewModelType {
    func numberOfItems()-> Int
}
class DailyTableViewCellViewModel: DailyTableViewCellViewModelType {
    
    //MARK:- Properties
    private let dailyData: Daily
    
    init(with daily:Daily) {
        self.dailyData = daily
    }
}
extension DailyTableViewCellViewModel {
    func numberOfItems()-> Int {
        dailyData.data?.count ?? 0
    }
}
