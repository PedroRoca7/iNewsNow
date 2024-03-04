//
//  WeatherService.swift
//  INewsNow
//
//  Created by Pedro Henrique on 01/03/24.
//

import Foundation

protocol WeatherServicing {
    func fecthData(city: String, _ completion: @escaping (ForecastResponseModel?) -> Void)
}

final class WeatherService: WeatherServicing {
    private let baseURL: String = "https://api.hgbrasil.com/weather"
    private let apiKey: String = "SUA-CHAVE"
    private let session = URLSession.shared
    
    func fecthData(city: String, _ completion: @escaping (ForecastResponseModel?) -> Void) {
        let cityName = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "\(baseURL)?key=\(apiKey)&city_name=\(cityName)"

        guard let url = URL(string: urlString) else { return }
        
        let task = session.dataTask(with: url) { data, response, error in
            guard let data else {
                completion(nil)
                return
            }
            do {
                let forecastResponse = try JSONDecoder().decode(ForecastResponseModel.self, from: data)
                completion(forecastResponse)
            } catch {
                print(error)
                completion(nil)
            }
        }
        task.resume()
    }
}

