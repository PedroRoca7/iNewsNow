//
//  TabBarController.swift
//  INewsNow
//
//  Created by Pedro Henrique on 09/02/24.
//

import Foundation
import UIKit

final class TabBarController: UITabBarController {
    
    override func setViewControllers(_ viewControllers: [UIViewController]?, animated: Bool) {
        super.setViewControllers(viewControllers, animated: animated)
        self.tabBar.isTranslucent = false
        self.tabBar.backgroundColor = .white
    }
}

