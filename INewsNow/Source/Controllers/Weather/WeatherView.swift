//
//  WeatherView.swift
//  INewsNow
//
//  Created by Pedro Henrique on 01/03/24.
//

import Foundation
import UIKit

final class WeatherView: UIView {
    
    //MARK: Propertys
    private lazy var safeGuide = self.safeAreaLayoutGuide
    
    //MARK: ElementsVisual
    
    //MARK: Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension WeatherView: ViewProtocol {
    func buildHierarchy() {
        <#code#>
    }
    
    func setupConstraints() {
        <#code#>
    }
}
