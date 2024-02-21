//
//  HomeCoordinator.swift
//  INewsNow
//
//  Created by Pedro Henrique on 09/02/24.
//

import Foundation
import UIKit

protocol WorldNewsCoordinating {
    func showScreenWebViewController(webSiteNews: String)
}

final class WorldNewsCoordinator: WorldNewsCoordinating {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func showScreenWebViewController(webSiteNews: String) {
        let webViewController = ScreenWebFactory.makeModule(navigationController: navigationController, webSiteNews: webSiteNews)
        navigationController.pushViewController(webViewController, animated: true)
    }
}
