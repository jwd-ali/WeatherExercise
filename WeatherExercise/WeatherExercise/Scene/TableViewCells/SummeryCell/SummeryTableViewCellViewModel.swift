//
//  SummeryTableViewCellViewModel.swift
//  WeatherExercise
//
//  Created by Jawad Ali on 24/10/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

import Foundation
protocol SummeryTableViewCellViewModelType {
    var summeryBinder: Binder<String>{ get }
  
    
}
class SummeryTableViewCellViewModel: SummeryTableViewCellViewModelType, WeatherCellItem {
    
    //MARK:- Properties
    private let summery: String
    var summeryBinder = Binder(" ")
    
    var type: WeatherCellItemType = .summeryCell
    
    init(with summery:String) {
        self.summery = summery
        bindValues()
    }
}
private extension SummeryTableViewCellViewModel {
    func bindValues() {
        summeryBinder.value = summery
    }
    
}
