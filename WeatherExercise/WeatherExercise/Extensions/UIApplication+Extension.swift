//
//  UIApplication+Extension.swift
//  WeatherExercise
//
//  Created by Jawad Ali on 26/10/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

import UIKit

extension UIApplication {


    @discardableResult
    static func openAppSettings() -> Bool {
        guard
            let settingsURL = URL(string: UIApplication.openSettingsURLString),
            UIApplication.shared.canOpenURL(settingsURL)
            else {
                return false
        }

        UIApplication.shared.open(settingsURL)
        return true
    }
}

