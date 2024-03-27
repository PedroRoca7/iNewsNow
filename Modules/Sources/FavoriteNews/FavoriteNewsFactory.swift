//
//  FavoriteNewsFactory.swift
//  INewsNow
//
//  Created by Pedro Henrique on 16/02/24.
//

import Foundation
import UIKit
import INewsNowCore

enum FavoriteNewsFactory {
    static func makeModule(navigationController: UINavigationController, coreDataService: CoreDataHelperService) -> UIViewController {
        let coordinator = FavoriteNewsCoordinator(navigationController: navigationController)
        let viewModel = FavoriteNewsViewModel(coordinator: coordinator)
        let viewController = FavoriteNewsViewController(viewModel: viewModel, coreDataService: coreDataService)
        return viewController
    }
}
