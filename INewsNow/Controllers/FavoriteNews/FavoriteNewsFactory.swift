//
//  FavoriteNewsFactory.swift
//  INewsNow
//
//  Created by Pedro Henrique on 16/02/24.
//

import Foundation
import UIKit

enum FavoriteNewsFactory {
    static func makeModule(navigationController: UINavigationController) -> UIViewController {
        let coordinator = FavoriteNewsCoordinator(navigationController: navigationController)
        let viewModel = FavoriteNewsViewModel(coordinator: coordinator)
        let viewController = FavoriteNewsViewController(viewModel: viewModel)
        return viewController
    }
}
