//
//  WeatherFactory.swift
//  INewsNow
//
//  Created by Pedro Henrique on 01/03/24.
//

import Foundation
import UIKit

enum WeatherFactory {
    static func makeModule() -> UIViewController {
        let viewModel = WeatherViewModel()
        let viewController = WeatherViewController(viewModel: viewModel)
        return viewController
    }
}
