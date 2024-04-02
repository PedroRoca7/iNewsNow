//
//  WeatherViewController.swift
//  INewsNow
//
//  Created by Pedro Henrique on 01/03/24.
//

import Foundation
import UIKit
import Lottie

final class WeatherViewController: UIViewController {
    
    //MARK: - Propertys
    
    private lazy var viewScreen: WeatherView = {
        let view = WeatherView()
        return view
    }()
    
    private var viewModel: WeatherViewModeling
    
    //MARK: - Inits
    
    init(viewModel: WeatherViewModeling) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func loadView() {
        view = viewScreen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.navigationController?.navigationBar.isHidden = true
        viewModel.getForecast(forThis: "São Paulo")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegatesAndDataSource()
        viewScreen.loaderView.isHidden = false
        viewScreen.loader.startAnimating()
    }
    
    private func checkDateAndSetBackgorundViewColor(withWeather weather: WeatherType) {
        switch weather {
        case .day:
            viewScreen.backgroundImage.image = UIImage(named: "backgroundClearDay")
        case .night:
            viewScreen.backgroundImage.image = UIImage(named: "backgroundClearNight")
        case .cloud:
            viewScreen.backgroundImage.image = UIImage(named: "backgroundCloud")
        case .rain:
            viewScreen.backgroundImage.image = UIImage(named: "backgroundRain")
        }
    }
    
    private func setDelegatesAndDataSource() {
        viewScreen.dailyForecastTableView.delegate = self
        viewScreen.dailyForecastTableView.dataSource = self
        viewModel.delegate = self
        viewScreen.serachCity.delegate = self
    }
    
    private func loadData() {
        guard let forecastCity = viewModel.forescastCity?.results else { return }
        viewScreen.cityLabel.text = forecastCity.city
        viewScreen.temperatureLabel.text = forecastCity.temp.toCelsius()
        viewScreen.humidityValueLabel.text = "\(forecastCity.humidity)mm"
        viewScreen.windValueLabel.text = forecastCity.windSpeed
        viewScreen.changeAnimation(named: forecastCity.conditionSlug)
        checkDateAndSetBackgorundViewColor(withWeather: WeatherType.fromString(forecastCity.conditionSlug))
    }
}

extension WeatherViewController: WeatherViewModelDelegate {
    func success(forecastCity: ForecastResponseModel) {
        DispatchQueue.main.async {
            self.viewScreen.dailyForecastTableView.reloadData()
            self.loadData()
            self.viewScreen.loaderView.isHidden = true
            self.viewScreen.loader.stopAnimating()
        }
    }
    
    func failure() {
        self.viewScreen.loaderView.isHidden = true
        self.viewScreen.loader.stopAnimating()
    }
}

extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.forecastDayList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DailyForecastTableViewCell.identifier, for: indexPath) as? DailyForecastTableViewCell else {
            return UITableViewCell()
        }
        
        let forecast = viewModel.forecastDayList[indexPath.row]
        cell.prepareCell(weekDay: forecast.weekday.uppercased(), min: forecast.min, max: forecast.max, icon: forecast.condition)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension WeatherViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            viewScreen.loaderView.isHidden = false
            viewScreen.loader.startAnimating()
            viewModel.getForecast(forThis: searchText)
        }
    }
}
