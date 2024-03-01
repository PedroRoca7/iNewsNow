//
//  HourlyForecastCollectionViewCell.swift
//  INewsNow
//
//  Created by Pedro Henrique on 01/03/24.
//

import Foundation
import UIKit

final class HourlyForecastCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "HourlyForecastCollectionViewCell"
    
    private lazy var viewScreen: HourlyForecastCellView = {
        let view = HourlyForecastCellView()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepareCell(time: String?, icon: UIImage?, temp: String?) {
        viewScreen.hourLabel.text = time
        viewScreen.iconImageView.image = icon
        viewScreen.temperatureLabel.text = temp
    }
    
}

extension HourlyForecastCollectionViewCell: ViewProtocol {
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
    
}
