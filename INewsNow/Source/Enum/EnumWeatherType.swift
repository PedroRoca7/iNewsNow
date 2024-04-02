//
//  EnumWeatherType.swift
//  INewsNow
//
//  Created by Pedro Henrique on 02/04/24.
//

import Foundation

enum WeatherType {
    case day
    case night
    case cloud
    case rain
    
    static func fromString(_ stringValue: String) -> WeatherType {
        switch stringValue {
        case "clear_day", "none_day":
            return .day
        case "clear_night", "none_night":
            return .night
        case "cloud", "cloudly_night", "cloudly_day", "fog":
            return .cloud
        case "rain", "snow", "hail", "storm":
            return .rain
        default:
            fatalError("Tipo desconhecido: \(stringValue)")
        }
    }
}
