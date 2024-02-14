//
//  CustomTabBar.swift
//  INewsNow
//
//  Created by Pedro Henrique on 14/02/24.
//

//import Foundation
//import UIKit
//
//final class CustomTabBar: UITabBar {
//    
//    private var middleButton = UIButton()
//    
//    setupMiddleButton()
//    
// 
//    
//    private func setupMiddleButton() {
//        middleButton.translatesAutoresizingMaskIntoConstraints = false
//        middleButton.backgroundColor = UIColor(named: "red")
//        middleButton.layer.cornerRadius = 32
//        middleButton.setImage(UIImage(named: "Home-icon"), for: .normal)
//        middleButton.addTarget(self, action: #selector(middleButtonAction), for: .touchUpInside)
//        addSubview(middleButton)
//        configConstraints()
//    }
//    
//    private func configConstraints() {
//        NSLayoutConstraint.activate([
//            middleButton.widthAnchor.constraint(equalToConstant: 64),
//            middleButton.heightAnchor.constraint(equalToConstant: 64),
//            middleButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//            middleButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15)
//        ])
//    }
//    
//    @objc private func middleButtonAction(sender: UIButton) {
//        print("Ola")
//        guard let homeViewController = homeViewController else { return }
//        if let tabBarIndex = homeViewController.tabBarController?.viewControllers?.firstIndex(of: homeViewController) {
//            homeViewController.tabBarController?.selectedIndex = tabBarIndex
//        }
//    }
//}
