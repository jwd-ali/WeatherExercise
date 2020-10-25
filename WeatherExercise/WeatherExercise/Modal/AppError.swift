//
//  AppError.swift
//  WeatherExercise
//
//  Created by Jawad Ali on 20/10/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

import Foundation
public struct AppError: Codable,Error {
    let error : String
   
    static func generalError() -> AppError{
        return AppError(error: "something went wrong")
    }
    
    init(error: String) {
        self.error = error
    }
}

extension AppError {
    private enum CodingKeys: String, CodingKey {
        case error = "Error"
    }
}

struct AlertAction {
    let buttonTitle: String
    let handler: (() -> Void)?
}

struct AppAlert {
    let title: String
    let message: String?
    let actions: [AlertAction]
}
