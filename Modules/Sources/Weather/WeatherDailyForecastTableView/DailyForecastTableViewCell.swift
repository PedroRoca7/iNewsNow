//
//  DailyForecastTableViewCell.swift
//  INewsNow
//
//  Created by Pedro Henrique on 01/03/24.
//

import Foundation
import UIKit
import INewsNowCore

final class DailyForecastTableViewCell: UITableViewCell {
    
    static let identifier: String = "DailyForecastTableViewCell"
    
    private lazy var viewScreen: DailyForecastCellView = {
        let view = DailyForecastCellView()
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepareCell(weekDay: String?, min: Int, max: Int, icon: String) {
        viewScreen.weekDayLabel.text = weekDay
        viewScreen.minTemperatureLabel.text = "min \(min)"
        viewScreen.maxTemperatureLabel.text = "max \(max)"
        viewScreen.iconImageView.image = UIImage(named: icon)
    }
}

extension DailyForecastTableViewCell: ViewProtocol {
    func buildHierarchy() {
        contentView.addSubview(viewScreen)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            viewScreen.topAnchor.constraint(equalTo: contentView.topAnchor),
            viewScreen.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            viewScreen.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            viewScreen.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func applyAdditionalChanges() {
        viewScreen.translatesAutoresizingMaskIntoConstraints = false
        selectionStyle = .none
        backgroundColor = .clear
    }
}
