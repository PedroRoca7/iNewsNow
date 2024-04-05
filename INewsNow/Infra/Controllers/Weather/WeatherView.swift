//
//  WeatherView.swift
//  INewsNow
//
//  Created by Pedro Henrique on 01/03/24.
//

import Foundation
import UIKit
import Lottie

final class WeatherView: UIView {
    
    //MARK: Propertys
    private lazy var safeGuide = self.safeAreaLayoutGuide
    
    //MARK: ElementsVisual
    
    lazy var backgroundImage: UIImageView = {
        let element = UIImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.contentMode = .scaleAspectFill
        element.alpha = 0.5
        return element
    }()
    
    lazy var serachCity: UISearchBar = {
        let element = UISearchBar()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.placeholder = "Pesquise por cidade"
        element.backgroundImage = UIImage()
        element.searchTextField.backgroundColor = .white
        return element
    }()
    
    private lazy var headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        return view
    }()
    
    lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "São Paulo"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .azulClaro
        return label
    }()
    
    lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 55, weight: .bold)
        label.textAlignment = .left
        label.textColor = .azulClaro
        return label
    }()
    
    lazy var weatherIcon: LottieAnimationView = {
        let element = LottieAnimationView(name: "fog")
        element.translatesAutoresizingMaskIntoConstraints = false
        element.contentMode = .scaleAspectFit
        element.loopMode = .loop
        element.animationSpeed = 1.0
        element.play()
        return element
    }()
    
    private lazy var humidityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Umidade"
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    lazy var humidityValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    private lazy var humidityStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [humidityLabel, humidityValueLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        return stackView
    }()
    
    private lazy var windLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Vento"
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
     lazy var windValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    private lazy var windStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [windLabel, windValueLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        return stackView
    }()
    
    private lazy var statsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [humidityStackView, windStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 3
        stackView.backgroundColor = .lightGray
        stackView.layer.cornerRadius = 10
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 12,
                                                                     leading: 24,
                                                                     bottom: 12,
                                                                     trailing: 24)
        return stackView
    }()
    
    private lazy var dailyForecastLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "PRÓXIMOS DIAS"
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    lazy var dailyForecastTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorColor = .white
        tableView.register(DailyForecastTableViewCell.self, forCellReuseIdentifier: DailyForecastTableViewCell.identifier)
        return tableView
    }()
    
    lazy var loaderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    lazy var loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView(style: .large)
        loader.translatesAutoresizingMaskIntoConstraints = false
        return loader
    }()
    
    //MARK: Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeAnimation(named animationName: String) {
      
        if animationName == "cloudly_day" {
            weatherIcon.stop()
            weatherIcon.removeFromSuperview()
            weatherIcon = LottieAnimationView(name: "cloud")
            weatherIcon.translatesAutoresizingMaskIntoConstraints = false
            weatherIcon.frame = bounds
            weatherIcon.contentMode = .scaleAspectFit
            weatherIcon.loopMode = .loop
            weatherIcon.animationSpeed = 1.0
        
            setupView()
            weatherIcon.play()
        } else {
            weatherIcon.stop()
            weatherIcon.removeFromSuperview()
            weatherIcon = LottieAnimationView(name: animationName)
            weatherIcon.translatesAutoresizingMaskIntoConstraints = false
            weatherIcon.frame = bounds
            weatherIcon.contentMode = .scaleAspectFit
            weatherIcon.loopMode = .loop
            weatherIcon.animationSpeed = 1.0
        
            setupView()
            weatherIcon.play()
        }
    }
}

extension WeatherView: ViewProtocol {
    func buildHierarchy() {
        self.addSubview(backgroundImage)
        self.addSubview(serachCity)
        self.addSubview(headerView)
        self.addSubview(statsStackView)
        self.addSubview(dailyForecastLabel)
        self.addSubview(dailyForecastTableView)
        self.addSubview(loaderView)
        
        headerView.addSubview(cityLabel)
        headerView.addSubview(temperatureLabel)
        headerView.addSubview(weatherIcon)
        
        loaderView.addSubview(loader)
        
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
        
            backgroundImage.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            serachCity.topAnchor.constraint(equalTo: self.topAnchor, constant: 40),
            serachCity.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            serachCity.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            headerView.topAnchor.constraint(equalTo: serachCity.bottomAnchor, constant: 5),
            headerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 35),
            headerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -35),
            headerView.heightAnchor.constraint(equalToConstant: 150),
            
            cityLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 10),
            cityLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 15),
            cityLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -15),
            cityLabel.heightAnchor.constraint(equalToConstant: 20),
            temperatureLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 12),
            temperatureLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 18),
            temperatureLabel.heightAnchor.constraint(equalToConstant: 60),
            weatherIcon.heightAnchor.constraint(equalToConstant: 120),
            weatherIcon.widthAnchor.constraint(equalToConstant: 120),
            weatherIcon.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -18),
            weatherIcon.centerYAnchor.constraint(equalTo: temperatureLabel.centerYAnchor),
            weatherIcon.leadingAnchor.constraint(equalTo: temperatureLabel.trailingAnchor, constant: 8),
            
            statsStackView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 24),
            statsStackView.widthAnchor.constraint(equalToConstant: 206),
            statsStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                        
            dailyForecastLabel.topAnchor.constraint(equalTo: statsStackView.bottomAnchor, constant: 29),
            dailyForecastLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 35),
            dailyForecastLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -35),
            dailyForecastTableView.topAnchor.constraint(equalTo: dailyForecastLabel.bottomAnchor, constant: 16),
            dailyForecastTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            dailyForecastTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            dailyForecastTableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            
            loaderView.topAnchor.constraint(equalTo: self.topAnchor),
            loaderView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            loaderView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            loaderView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            loader.centerXAnchor.constraint(equalTo: loaderView.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: loaderView.centerYAnchor),
        ])
    }
    
    func applyAdditionalChanges() {
        self.backgroundColor = .darkGray
    }
}
