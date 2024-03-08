//
//  CategoryNewsFactory.swift
//  INewsNow
//
//  Created by Pedro Henrique on 06/03/24.
//

import Foundation
import UIKit
import Service

 public enum CategoryNewsFactory {
    public static func makeModule(navigationController: UINavigationController, titleCategory: String) -> UIViewController {
        let service = NewsBrazilDataIOService()
        let coordinator = CategoryNewsCoordinator(navigationController: navigationController)
        let viewModel = CategoryNewsViewModel(service: service, coordinator: coordinator, titleCategory: titleCategory)
        let viewController = CategoryNewsViewController(viewModel: viewModel)
        viewModel.delegate = viewController
        
        return viewController
    }
}
