//
//  HomeFactory.swift
//  INewsNow
//
//  Created by Pedro Henrique on 20/02/24.
//

import Foundation
import UIKit

enum HomeFactory {
    static func makeModule(navigationController: UINavigationController) -> UIViewController {
        let service = NewsBrazilDataIOService()
        let coordinator = HomeCoordinator(navigationController: navigationController)
        let viewModel = HomeViewModel(service: service, coordinator: coordinator)
        let viewController = HomeViewController(viewModel: viewModel)
        
        viewModel.delegate = viewController
        
        return viewController
    }
}
