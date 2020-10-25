//
//  Binder.swift
//  WeatherExercise
//
//  Created by Jawad Ali on 23/10/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

import Foundation
class Binder<T> {
    typealias BinderListener = (T) -> Void
    
    var listener: BinderListener?
    var value: T {
        didSet {
            self.listener?(self.value)
        }
    }
    
    func bind(_ listener: @escaping BinderListener) {
        self.listener = listener
        self.listener?(self.value)
    }
    
    func set(to value: T) {
        self.value = value
    }
    
    init(_ value: T) {
        self.value = value
    }
}
