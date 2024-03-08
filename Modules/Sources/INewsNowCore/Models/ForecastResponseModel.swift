//
//  ForecastResponseModel.swift
//  INewsNow
//
//  Created by Pedro Henrique on 01/03/24.
//

import Foundation

public struct ForecastResponseModel: Codable {
    public let results: Weather
}

public struct Weather: Codable {
    public let city: String
    public let date: String
    public let temp: Int
    public let humidity: Int
    public let windSpeed: String
    public let conditionSlug: String
    public let forecast: [Forecast]

    enum CodingKeys: String, CodingKey {
        case date, temp, humidity, city
        case windSpeed = "wind_speedy"
        case forecast
        case conditionSlug = "condition_slug"
    }
}

public struct Forecast: Codable {
    public let date, weekday, description, condition: String
    public let max, min, rainProbability: Int
    
    enum CodingKeys: String, CodingKey {
        case date, weekday, description, condition
        case max, min
        case rainProbability = "rain_probability"
    }
}
