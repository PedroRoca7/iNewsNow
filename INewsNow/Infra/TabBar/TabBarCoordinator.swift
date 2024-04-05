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
        let tabBarController = TabBarFactory.makeModule(navigationController: navigationController)
 
        navigationController.setViewControllers([tabBarController], animated: true)
        return navigationController
    }
}
