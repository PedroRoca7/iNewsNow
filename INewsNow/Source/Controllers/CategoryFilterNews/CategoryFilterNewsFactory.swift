//
//  MenuFilterNewsFactory.swift
//  INewsNow
//
//  Created by Pedro Henrique on 04/03/24.
//

import Foundation
import UIKit

enum MenuFilterNewsFactory {
    static func makeModule(navigationController: UINavigationController) -> UIViewController {
        let coordinator = CategoryFilterNewsCoordinator(navigationController: navigationController)
        let viewModel = CategoryFilterNewsViewModel(coordinator: coordinator)
        let viewController = CategoryFilterNewsViewController(viewModel: viewModel)
        return viewController
    }
}
