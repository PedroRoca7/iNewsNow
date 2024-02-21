//
//  NewsBrazilFactory.swift
//  INewsNow
//
//  Created by Pedro Henrique on 20/02/24.
//

import Foundation
import UIKit

enum NewsBrazilFactory {
    static func makeModule(navigationController: UINavigationController) -> UIViewController {
        let service = NewsBrazilDataIOService()
        let newsBrazilViewModel = NewsBrazilViewModel(service: service)
        let newsBrazilViewController = NewsBrasilViewController(viewModel: newsBrazilViewModel)
        return newsBrazilViewController
    }
}
