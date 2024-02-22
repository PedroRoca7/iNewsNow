//
//  NewsBrazilCoordinator.swift
//  INewsNow
//
//  Created by Pedro Henrique on 21/02/24.
//

import Foundation
import UIKit

protocol HomeCoordinating {
    func showNewsWorld()
    func showScreenDetailsNews<T>(newsObject: T)
}

final class HomeCoordinator: HomeCoordinating {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func showNewsWorld() {
        let worldNews = WorldNewsFactory.makeModule(navigationController: navigationController)
        navigationController.pushViewController(worldNews, animated: true)
    }
    
    func showScreenDetailsNews<T>(newsObject: T) {
        let detaislNews = DetailsNewsFactory.makeModule(navigationController: navigationController, newsObject: newsObject)
        navigationController.pushViewController(detaislNews, animated: true)
    }
}
