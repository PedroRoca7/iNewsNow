//
//  WeatherService.swift
//  INewsNow
//
//  Created by Pedro Henrique on 01/03/24.
//

import Foundation

protocol WeatherServiceDelegate: NSObject {
    func didFailForecastFetching()
    func didSuccedForecastFetching(forecast: ForecastResponseModel)
}

protocol WeatherServicing {
    var delegate: WeatherServiceDelegate? { get set }
    func fecthData(city: String)
}

final class WeatherService: WeatherServicing {
    weak var delegate: WeatherServiceDelegate?
    private let baseURL: String = "https://api.hgbrasil.com/weather"
    private let apiKey: String = "SUA-CHAVE"
    private let session = URLSession.shared
    
    func fecthData(city: String) {
        let cityName = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "\(baseURL)?key=\(apiKey)&city_name=\(cityName)"

        guard let url = URL(string: urlString) else { return }
        
        let task = session.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self,
                  let data = data else {
                self?.delegate?.didFailForecastFetching()
                return
            }
            do {
                let forecastResponse = try JSONDecoder().decode(ForecastResponseModel.self, from: data)
                self.delegate?.didSuccedForecastFetching(forecast: forecastResponse)
            } catch {
                #if DEBUG
                print(error)
                #endif
                self.delegate?.didFailForecastFetching()
            }
        }
        task.resume()
    }
}

