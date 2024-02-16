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
        let service = NewYorkTimesService()
        let homeViewModel = HomeViewModel(service: service, coordinator: coordinator)
        let homeViewController = HomeViewController(homeViewModel: homeViewModel)
        
        homeViewModel.delegate = homeViewController
        
        return homeViewController
    }
}
