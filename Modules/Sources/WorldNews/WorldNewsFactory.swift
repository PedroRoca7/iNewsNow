//
//  WorldNewsFactory.swift
//  INewsNow
//
//  Created by Pedro Henrique on 31/01/24.
//

import Foundation
import UIKit
import Service

public enum WorldNewsFactory {
    public static func makeModule(navigationController: UINavigationController) -> UIViewController {
        let coordinator = WorldNewsCoordinator(navigationController: navigationController)
        let service = NewYorkTimesService()
        let viewModel = WorldNewsViewModel(service: service, coordinator: coordinator)
        let viewController = WorldNewsViewController(viewModel: viewModel)
        
        viewModel.delegate = viewController
        
        return viewController
    }
}
