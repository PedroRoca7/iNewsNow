//
//  ScreenWebFactory.swift
//  INewsNow
//
//  Created by Pedro Henrique on 15/02/24.
//

import Foundation
import UIKit

enum ScreenWebFactory {
    static func makeModule(navigationController: UINavigationController, webSiteNews: String) -> UIViewController {
        let screenWebViewController = ScreenWebViewController(webSiteNews: webSiteNews)
        return screenWebViewController
    }
}
