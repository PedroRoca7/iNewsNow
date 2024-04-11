//
//  LaunchScreenView.swift
//  INewsNow
//
//  Created by Pedro Henrique on 08/04/24.
//

import Foundation
import UIKit
import Lottie

final class LaunchScreenView: UIView {
        
    //MARK: - ElementsVisual
    
    lazy var newsImageAnimation: LottieAnimationView = {
        let element = LottieAnimationView(name: "launchScreen")
        element.translatesAutoresizingMaskIntoConstraints = false
        element.contentMode = .scaleAspectFit
        element.loopMode = .loop
        element.animationSpeed = 1.0
        element.play()
        return element
    }()
    
    //MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension LaunchScreenView: ViewProtocol {
    func buildHierarchy() {
        self.addSubview(newsImageAnimation)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            newsImageAnimation.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            newsImageAnimation.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            newsImageAnimation.widthAnchor.constraint(equalToConstant: 300),
            newsImageAnimation.heightAnchor.constraint(equalToConstant: 300),
        ])
    }
    
    func applyAdditionalChanges() {
        self.backgroundColor = .backgroundColor
    }
}

