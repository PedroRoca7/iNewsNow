//
//  LaunchScreenViewController.swift
//  INewsNow
//
//  Created by Pedro Henrique on 08/04/24.
//

import Foundation
import UIKit
import Lottie

final class LaunchScreenViewController: UIViewController {
    
    lazy var viewScreen: LaunchScreenView = {
        let element = LaunchScreenView()
        return element
    }()
    
    override func loadView() {
        view = viewScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            let navigationController = UINavigationController()
            let tabBarCoordinator = TabBarCoordinator(navigationController: navigationController)
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                if let sceneDelegate = windowScene.delegate as? SceneDelegate {
                    if let window = sceneDelegate.window {
                        window.rootViewController = tabBarCoordinator.start()
                    }
                }
            }
        }
    }
}
