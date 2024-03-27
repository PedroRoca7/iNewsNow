//
//  WeatherViewModel.swift
//  INewsNow
//
//  Created by Pedro Henrique on 01/03/24.
//

import Foundation
import INewsNowCore
import Service

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

final class WeatherViewModel: WeatherViewModeling {
    
    private let service: WeatherServicing
    private(set) var forescastCity: ForecastResponseModel?
    private(set) var forecastDayList: [Forecast] = []
    weak var delegate: WeatherViewModelDelegate?
    
    init(service: WeatherServicing) {
        self.service = service
    }
        
    func getForecast(forThis city: String) {
        service.fecthData(city: city) { [weak self] forecastResult in
            guard let self = self else { return }
            self.forescastCity = forecastResult
            if let forescastCity = self.forescastCity {
                self.forecastDayList = forescastCity.results.forecast
                self.delegate?.success(forecastCity: forescastCity)
            } else {
                self.delegate?.failure()
            }
        }
    }
}
