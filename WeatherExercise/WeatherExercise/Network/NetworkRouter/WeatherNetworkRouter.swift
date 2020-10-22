//
//  WeatherNetworkRouter.swift
//  WeatherExercise
//
//  Created by Jawad Ali on 20/10/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

import Foundation

struct ProductionServer {
    static var host = "api.darksky.net"
    static var ApiKey = "2bb07c3bece89caf533ac9a5d23d8417"
}

public protocol URLRequestConvertible {
    func urlRequest()  -> URLRequest?
}
enum WeatherNetworkRouter<T>: URLRequestConvertible {
    
    case getWeather(T)
    
    private var scheme: String {
        switch self {
        case .getWeather:
            return "https"
        }
    }

    private var host: String {
        switch self {
        case .getWeather:
            return ProductionServer.host
        }
    }
    
    private var path: String {
        switch self {
        case .getWeather(let params):
             let request = params as! WeatherServiceRequest
             return  "/forecast/\(ProductionServer.ApiKey)/\(request.latitude),\(request.longitude)"
        }
    }
    
    private var method: String {
        switch self {
        case .getWeather:
            return "GET"
        }
    }

    func urlRequest() -> URLRequest? {
        var components = URLComponents()
        components.scheme = self.scheme
        components.host = self.host
        components.path = self.path
        
        guard let url = components.url else {
            assert(true,"url not formed")
            return nil
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = self.method
        
        return urlRequest
    }
}
