//
//  NewsBrazilCoordinator.swift
//  INewsNow
//
//  Created by Pedro Henrique on 21/02/24.
//

import Foundation
import UIKit

protocol NewsBrazilCoordinating {
    func showNewsWorld()
}

final class NewsBrazilCoordinator: NewsBrazilCoordinating {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func showNewsWorld() {
        let newsWorld = HomeFactory.makeModule(navigationController: navigationController)
        navigationController.pushViewController(newsWorld, animated: true)
    }
}
