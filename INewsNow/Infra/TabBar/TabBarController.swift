//
//  TabBarController.swift
//  INewsNow
//
//  Created by Pedro Henrique on 09/02/24.
//

import Foundation
import UIKit

final class TabBarController: UITabBarController {
    
    let tabBarView = TabBarView()
    
    override func loadView() {
        super.loadView()
        self.setValue(tabBarView, forKey: "tabBar")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        guard let navigationController = navigationController else { return }
        configureTabBarItems(navigationController: navigationController)
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        tabBarView.updateCurveForTappedIndex()
    }
 
    private func configureTabBarItems(navigationController: UINavigationController) {
        
        let homeViewController = HomeFactory.makeModule(navigationController: navigationController)
        homeViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "house.fill"), selectedImage: nil)
        
        let menuCategoryViewController = MenuFilterNewsFactory.makeModule(navigationController: navigationController)
        menuCategoryViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "menucard.fill"), selectedImage: nil)
        
        let weatherViewController = WeatherFactory.makeModule()
        weatherViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "sun.max.fill"), selectedImage: nil)
        
        let favoriteViewController = FavoriteNewsFactory.makeModule(navigationController: navigationController)
        favoriteViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "heart.fill"), selectedImage: nil)
        
        viewControllers = ([homeViewController, menuCategoryViewController, weatherViewController, favoriteViewController])
    }
}
