//
//  HomeFactory.swift
//  INewsNow
//
//  Created by Pedro Henrique on 31/01/24.
//

import Foundation
import UIKit

enum HomeFactory {
    static func makeModule(navigationController: UINavigationController) -> UIViewController {
        let coordinator = HomeCoordinator(navigationController: navigationController)
        let homeViewController = HomeViewController()
        return homeViewController
    }
}
