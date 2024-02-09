//
//  TabBarCoordinator.swift
//  INewsNow
//
//  Created by Pedro Henrique on 09/02/24.
//

import Foundation
import UIKit

final class TabBarCoordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() -> UIViewController {
        let tabBarController = TabBarController()
        
        let homeView = HomeFactory.makeModule(navigationController: navigationController)
        
        tabBarController.setViewControllers([homeView], animated: true)
        navigationController.setViewControllers([tabBarController], animated: true)
        return navigationController
    }
}
