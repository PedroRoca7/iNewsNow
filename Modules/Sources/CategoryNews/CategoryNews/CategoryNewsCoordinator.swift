//
//  CategoryNewsCoordinator.swift
//  INewsNow
//
//  Created by Pedro Henrique on 06/03/24.
//

import Foundation
import UIKit

protocol CategoryNewsCoordinating {
    func showScreenDetailsNews<T>(newsObject: T)
}

final class CategoryNewsCoordinator: CategoryNewsCoordinating {
 
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func showScreenDetailsNews<T>(newsObject: T) {
//        let detaislNews = DetailsNewsFactory.makeModule(navigationController: navigationController, newsObject: newsObject)
//        navigationController.pushViewController(detaislNews, animated: true)
    }
}
