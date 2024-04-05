//
//  DailyForecastCellView.swift
//  INewsNow
//
//  Created by Pedro Henrique on 01/03/24.
//

import Foundation
import UIKit

final class DailyForecastCellView: UIView {
    
    //MARK: - Propertys
    
    private lazy var safeGuide = self.safeAreaLayoutGuide
    
    //MARK: - ElementsVisual
    
    lazy var weekDayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        return label
    }()
    
    lazy var minTemperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        return label
    }()
    
    lazy var maxTemperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        return label
    }()
    
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    //MARK: - Inits
    
    private lazy var stackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [weekDayLabel,
                                                     iconImageView,
                                                     minTemperatureLabel,
                                                     maxTemperatureLabel])
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16,
                                                                     leading: 16,
                                                                     bottom: 16,
                                                                     trailing: 16)
        stackView.spacing = 15
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DailyForecastCellView: ViewProtocol {
    func buildHierarchy() {
        self.addSubview(stackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
        ])
    }
    
    func applyAdditionalChanges() {
        self.backgroundColor = .clear
    }
}
