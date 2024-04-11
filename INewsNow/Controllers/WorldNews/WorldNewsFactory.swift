//
//  WorldNewsFactory.swift
//  INewsNow
//
//  Created by Pedro Henrique on 31/01/24.
//

import Foundation
import UIKit

enum WorldNewsFactory {
    static func makeModule(navigationController: UINavigationController) -> UIViewController {
        let coordinator = WorldNewsCoordinator(navigationController: navigationController)
        let service = NewYorkTimesService()
        let viewModel = WorldNewsViewModel(service: service, coordinator: coordinator)
        let viewController = WorldNewsViewController(viewModel: viewModel)
        service.delegate = viewModel
        viewModel.delegate = viewController
        
        return viewController
    }
}
