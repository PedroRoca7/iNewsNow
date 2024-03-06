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
        let coordinator = MenuFilterNewsCoordinator(navigationController: navigationController)
        let viewModel = MenuFilterNewsViewModel(coordinator: coordinator)
        let viewController = MenuFilterNewsViewController(viewModel: viewModel)
        return viewController
    }
}
