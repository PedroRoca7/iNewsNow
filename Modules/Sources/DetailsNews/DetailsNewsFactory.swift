//
//  DetailsNewsFactory.swift
//  INewsNow
//
//  Created by Pedro Henrique on 22/02/24.
//

import Foundation
import UIKit

enum DetailsNewsFactory {
    static func makeModule<T>(navigationController: UINavigationController, newsObject: T) -> UIViewController {
        let viewController = DetailsNewsViewController(content: newsObject)
        return viewController
    }
}
 
