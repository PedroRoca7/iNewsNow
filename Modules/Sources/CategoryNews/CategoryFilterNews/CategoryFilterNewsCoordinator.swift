//
//  MenuFilterNewsCoordinator.swift
//  INewsNow
//
//  Created by Pedro Henrique on 06/03/24.
//

import Foundation
import UIKit

protocol CategoryFilterNewsCoordinating {
    func showScreenCategoryNews(titleCategory: String)
}

final class CategoryFilterNewsCoordinator: CategoryFilterNewsCoordinating {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func showScreenCategoryNews(titleCategory: String) {
        let categoryNews = CategoryNewsFactory.makeModule(navigationController: navigationController, titleCategory: titleCategory)
        navigationController.pushViewController(categoryNews, animated: true)
    }
}
