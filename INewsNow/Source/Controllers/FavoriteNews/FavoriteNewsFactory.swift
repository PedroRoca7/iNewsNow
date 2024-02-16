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
        let favoriteNewsViewController = FavoriteNewsViewController()
        return favoriteNewsViewController
    }
}
