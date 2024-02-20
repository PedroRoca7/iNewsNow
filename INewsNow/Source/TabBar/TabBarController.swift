//
//  TabBarController.swift
//  INewsNow
//
//  Created by Pedro Henrique on 09/02/24.
//

import Foundation
import UIKit

final class TabBarController: UITabBarController {
    
    private var middleButton = UIButton()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBar.isTranslucent = false
        self.tabBar.backgroundColor = UIColor(named: "backgroundColor")
        self.tabBar.tintColor = UIColor(named: "red")
        guard let navigationController = navigationController else { return }
        configureTabBarItems(navigationController: navigationController)
        setupMiddleButton()
        self.selectedIndex = 1
    }
    
    private func setupMiddleButton() {
        middleButton.translatesAutoresizingMaskIntoConstraints = false
        middleButton.backgroundColor = UIColor(named: "red")
        middleButton.layer.cornerRadius = 32
        middleButton.setImage(UIImage(named: "Home-icon"), for: .normal)
        middleButton.addTarget(self, action: #selector(middleButtonAction), for: .touchUpInside)
        self.tabBar.addSubview(middleButton)
        configConstraints()
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            middleButton.widthAnchor.constraint(equalToConstant: 64),
            middleButton.heightAnchor.constraint(equalToConstant: 64),
            middleButton.centerXAnchor.constraint(equalTo: self.tabBar.centerXAnchor),
            middleButton.bottomAnchor.constraint(equalTo: self.tabBar.bottomAnchor, constant: -15)
        ])
    }
    
    @objc private func middleButtonAction(sender: UIButton) {
        if let tabBarController = tabBar.delegate as? UITabBarController {
            tabBarController.selectedIndex = 1
        }
    }
    
    private func configureTabBarItems(navigationController: UINavigationController) {
        
        let mainMenuViewController = MainMenuViewController()
        mainMenuViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "menucard.fill"), selectedImage: nil)
        let homeViewController = HomeFactory.makeModule(navigationController: navigationController)
        homeViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: ""), selectedImage: nil)
        let favoriteViewController = FavoriteNewsFactory.makeModule(navigationController: navigationController)
        favoriteViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "heart.fill"), selectedImage: nil)
        
        viewControllers = ([mainMenuViewController, homeViewController, favoriteViewController])
    }
}
