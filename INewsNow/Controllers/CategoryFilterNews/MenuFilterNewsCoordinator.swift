//
//  MenuFilterNewsCoordinator.swift
//  INewsNow
//
//  Created by Pedro Henrique on 06/03/24.
//

import Foundation
import UIKit

protocol MenuFilterNewsCoordinating {
    func showScreenCategoryNews(titleCategory: String)
    func showScreenNewYorkTimesNews()
}

final class MenuFilterNewsCoordinator: MenuFilterNewsCoordinating {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func showScreenCategoryNews(titleCategory: String) {
        let categoryNews = CategoryNewsFactory.makeModule(navigationController: navigationController, titleCategory: titleCategory)
        navigationController.pushViewController(categoryNews, animated: true)
    }
    
    func showScreenNewYorkTimesNews() {
        let newYorkTimesNews = WorldNewsFactory.makeModule(navigationController: navigationController)
        navigationController.pushViewController(newYorkTimesNews, animated: true)
    }
}
