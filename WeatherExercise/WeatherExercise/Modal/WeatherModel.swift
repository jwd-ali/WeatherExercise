//
//  WeatherModel.swift
//  WeatherExercise
//
//  Created by Jawad Ali on 20/10/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

import Foundation
import Foundation

// MARK: - WeatherModel
struct WeatherModel: Codable, SegregatedWeatherModel {
    let latitude, longitude: Double?
    let timezone: String?
    let currently: Currently?
    let hourly: Hourly?
    let daily: Daily?
    let alerts: [Alert]?
    let flags: Flags?
    let offset: Double?
}

// MARK: - Alert
struct Alert: Codable {
    let title: String?
    let regions: [String]?
    let severity: String?
    let time, expires: Double?
    let alertDescription: String?
    let uri: String?

    enum CodingKeys: String, CodingKey {
        case title, regions, severity, time, expires
        case alertDescription = "description"
        case uri
    }
}

// MARK: - Currently
struct Currently: Codable, SegregatedCurrently {
    let time: Double?
    let summary: String?
    let icon: Icon?
    let precipIntensity, precipProbability, temperature, apparentTemperature: Double?
    let dewPoint, humidity, pressure, windSpeed: Double?
    let windGust: Double?
    let windBearing: Int?
    let cloudCover: Double?
    let uvIndex: Int?
    let visibility, ozone: Double?
    let precipType: Icon?
}

enum Icon: String, Codable {
    case cloudy = "cloudy"
    case partlyCloudyDay = "partly-cloudy-day"
    case partlyCloudyNight = "partly-cloudy-night"
    case rain = "rain"
    case snow = "snow"
    case wind = "wind"
    case sleet = "sleet"
    case fog = "fog"
    case clearDay = "clear-day"
    case clearNight = "clear-night"
    
}

// MARK: - Daily
struct Daily: Codable {
    let summary: String?
    let icon: Icon?
    let data: [Datum]?
}

// MARK: - Datum
struct Datum: Codable, SegregatedDatum, SegregatedDetails {
    let time: Double?
    let summary: String?
    let icon: Icon?
    let sunriseTime, sunsetTime: Double?
    let moonPhase, precipIntensity, precipIntensityMax: Double?
    let precipIntensityMaxTime: Int?
    let precipProbability: Double?
    let precipType: Icon?
    let temperatureHigh: Double?
    let temperatureHighTime: Double?
    let temperatureLow: Double?
    let temperatureLowTime: Double?
    let apparentTemperatureHigh: Double?
    let apparentTemperatureHighTime: Double?
    let apparentTemperatureLow: Double?
    let apparentTemperatureLowTime: Double?
    let dewPoint, humidity, pressure, windSpeed: Double?
    let windGust: Double?
    let windGustTime, windBearing: Double?
    let cloudCover: Double?
    let uvIndex, uvIndexTime: Double?
    let visibility, ozone, temperatureMin: Double?
    let temperatureMinTime: Double?
    let temperatureMax: Double?
    let temperatureMaxTime: Double?
    let apparentTemperatureMin: Double?
    let apparentTemperatureMinTime: Double?
    let apparentTemperatureMax: Double?
    let apparentTemperatureMaxTime: Double?
}

// MARK: - Flags
struct Flags: Codable {
    let sources: [String]?
    let meteoalarmLicense: String?
    let nearestStation: Double?
    let units: String?

    enum CodingKeys: String, CodingKey {
        case sources
        case meteoalarmLicense = "meteoalarm-license"
        case nearestStation = "nearest-station"
        case units
    }
}

// MARK: - Hourly
struct Hourly: Codable {
    let summary: String?
    let icon: Icon?
    let data: [Currently]?
}


// Segregated Protocols to implement interface segregation
protocol SegregatedWeatherModel {
    var currently: Currently? { get }
    var hourly: Hourly? { get }
    var daily: Daily? { get }
}


protocol SegregatedDatum {
    var time: Double? { get }
    var icon: Icon? { get }
    var temperatureLow: Double? { get }
    var temperatureHigh: Double? { get }
}

protocol SegregatedCurrently {
    var time: Double? { get }
    var icon: Icon? { get }
    var temperature: Double? { get }
}

protocol SegregatedDetails {
    var sunriseTime: Double? { get }
    var sunsetTime: Double? { get }
    var precipProbability: Double? { get }
    var humidity: Double? { get }
    var windSpeed: Double? { get }
    var pressure: Double? { get }
    var visibility: Double? { get }
    var uvIndex:Double? { get }
}
