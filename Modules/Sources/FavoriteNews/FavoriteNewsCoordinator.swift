//
//  FavoriteNewsCoordinator.swift
//  INewsNow
//
//  Created by Pedro Henrique on 16/02/24.
//

import Foundation
import UIKit

protocol FavoriteNewsCoordinating {
    func showScreenDetailsNews<T>(newsObject: T)
}

final class FavoriteNewsCoordinator: FavoriteNewsCoordinating {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func showScreenDetailsNews<T>(newsObject: T) {
//        let detaislNews = DetailsNewsFactory.makeModule(navigationController: navigationController, newsObject: newsObject)
//        navigationController.pushViewController(detaislNews, animated: true)
    }
}


