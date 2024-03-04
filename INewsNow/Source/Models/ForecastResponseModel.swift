//
//  ForecastResponseModel.swift
//  INewsNow
//
//  Created by Pedro Henrique on 01/03/24.
//

import Foundation

struct ForecastResponseModel: Codable {
    let results: Weather
}

struct Weather: Codable {
    let city: String
    let date: String
    let temp: Int
    let humidity: Int
    let windSpeed: String
    let conditionSlug: String
    let forecast: [Forecast]

    enum CodingKeys: String, CodingKey {
        case date, temp, humidity, city
        case windSpeed = "wind_speedy"
        case forecast
        case conditionSlug = "condition_slug"
    }
}

struct Forecast: Codable {
    let date, weekday, description, condition: String
    let max, min, rainProbability: Int
    
    enum CodingKeys: String, CodingKey {
        case date, weekday, description, condition
        case max, min
        case rainProbability = "rain_probability"
    }
}
