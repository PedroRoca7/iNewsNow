//
//  WorldNewsFactory.swift
//  INewsNow
//
//  Created by Pedro Henrique on 31/01/24.
//

import Foundation
import UIKit
import Service
import INewsNowCore

public enum WorldNewsFactory {
    public static func makeModule(navigationController: UINavigationController, coreDataService: CoreDataHelperService) -> UIViewController {
        let coordinator = WorldNewsCoordinator(navigationController: navigationController)
        let service = NewYorkTimesService()
        let viewModel = WorldNewsViewModel(service: service, coordinator: coordinator, coreDataService: coreDataService)
        let viewController = WorldNewsViewController(viewModel: viewModel)
        
        viewModel.delegate = viewController
        
        return viewController
    }
}
