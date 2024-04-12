//
//  HomeFactory.swift
//  INewsNow
//
//  Created by Pedro Henrique on 20/02/24.
//

import Foundation
import UIKit

enum HomeFactory {
    static func makeModule(navigationController: UINavigationController) -> UIViewController {
        let service = NewsBrazilDataIOService()
        let coordinator = HomeCoordinator(navigationController: navigationController)
        let presenter = HomePresenter()
        let interactor = HomeInteractor(service: service, presenter: presenter)
        let viewController = HomeViewController(interactor: interactor, coordinator: coordinator)
        service.delegate = interactor
        presenter.controller = viewController
        
        return viewController
    }
}
