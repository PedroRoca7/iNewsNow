//
//  WeatherViewModel.swift
//  INewsNow
//
//  Created by Pedro Henrique on 01/03/24.
//

import Foundation

protocol WeatherViewModeling {
    func getForecast(forThis city: String)
    var forecastDayList: [Forecast] { get }
    var forescastCity: ForecastResponseModel? { get }
    var delegate: WeatherViewModelDelegate? { get set }
}

protocol WeatherViewModelDelegate: AnyObject {
    func success(forecastCity: ForecastResponseModel)
    func failure()
}

final class WeatherViewModel: NSObject, WeatherViewModeling {
    
    private let service: WeatherServicing
    private(set) var forescastCity: ForecastResponseModel?
    private(set) var forecastDayList: [Forecast] = []
    weak var delegate: WeatherViewModelDelegate?
    
    init(service: WeatherServicing) {
        self.service = service
    }
        
    func getForecast(forThis city: String) {
        service.fecthData(city: city)
    }
}

extension WeatherViewModel: WeatherServiceDelegate {
    func didFailForecastFetching() {
        self.delegate?.failure()
    }
    
    func didSuccedForecastFetching(forecast: ForecastResponseModel) {
        self.forescastCity = forecast
        self.forecastDayList = forecast.results.forecast
        self.delegate?.success(forecastCity: forecast)
    }
}
