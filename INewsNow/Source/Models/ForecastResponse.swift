//
//  ForecastResponse.swift
//  INewsNow
//
//  Created by Pedro Henrique on 01/03/24.
//

import Foundation

struct ForecastResponse: Codable {
    let current: Forecast
    let hourly: [Forecast]
    let daily: [DailyForecast]
}

struct Forecast: Codable {
    let dt: Int
    let temp: Double
    let humidity: Int
    let windSpeed: Double
    let weather: [Weather]

    enum CodingKeys: String, CodingKey {
        case dt, temp, humidity
        case windSpeed = "wind_speed"
        case weather
    }
}

struct Weather: Codable {
    let id: Int
    let main, description, icon: String
}

struct DailyForecast: Codable {
    let dt: Int
    let temp: Temp
    let weather: [Weather]
}

struct Temp: Codable {
    let day, min, max, night: Double
    let eve, morn: Double
}
