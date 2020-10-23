//
//  Double+Extenstion.swift
//  WeatherExercise
//
//  Created by Jawad Ali on 20/10/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

import Foundation
extension Double {
    func twelveHours() -> String {
        let dateFormatter = DateFormatter()
        let date = Date(timeIntervalSince1970: self)
        
        // Returns date formatted as 12 hour time.
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.string(from: date)
    }
    
    func daySting() -> String {
        let dateFormatter = DateFormatter()
        let date = Date(timeIntervalSince1970: self)
        
        dateFormatter.locale = Locale(identifier: Locale.current.identifier)
        dateFormatter.dateFormat = "EEEE"
        
        return dateFormatter.string(from: date)
    }
    
    func convertFahrenheitToCelsius() -> Double {
        return (self - 32) / 1.8
    }
}
