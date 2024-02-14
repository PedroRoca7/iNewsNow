//
//  TabBarFactory.swift
//  INewsNow
//
//  Created by Pedro Henrique on 09/02/24.
//

import Foundation
import UIKit

enum TabBarFactory {
    static func makeModule(navigationController: UINavigationController) -> UITabBarController {
        let tabBarController = TabBarController()
        return tabBarController
    }
}
