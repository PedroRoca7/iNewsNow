//
//  HomeView.swift
//  INewsNow
//
//  Created by Pedro Henrique on 31/01/24.
//

import Foundation
import UIKit

class HomeView: UIView {
    
    // MARK: Propertys
    
    lazy var safeGuide = self.safeAreaLayoutGuide
    
    // MARK: ElementsVisual
    
    lazy var floatingMenuButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "car"), for: .normal)
        return button
    }()
    
    lazy var logoImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.image = UIImage(named: "LogoINewsNowBottomless")
        return image
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "car"), for: .normal)
        return button
    }()
    
    lazy var stackViewHeader: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [floatingMenuButton, logoImageView, searchButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        return stackView
    }()
    
    lazy var mainNewsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Main News"
        label.font = .boldSystemFont(ofSize: 22)
        return label
    }()
    
    lazy var todayDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Wednesday, November 18 - 2019"
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView()
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension HomeView: ViewProtocol {
    func buildHierarchy() {
        self.addSubview(stackViewHeader)
        self.addSubview(mainNewsLabel)
        self.addSubview(todayDateLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            floatingMenuButton.widthAnchor.constraint(equalToConstant: 25),
            floatingMenuButton.heightAnchor.constraint(equalToConstant: 25),
                        
            searchButton.widthAnchor.constraint(equalToConstant: 25),
            searchButton.heightAnchor.constraint(equalToConstant: 25),
            
            stackViewHeader.topAnchor.constraint(equalTo: safeGuide.topAnchor, constant: 10),
            stackViewHeader.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            stackViewHeader.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            stackViewHeader.heightAnchor.constraint(equalToConstant: 70),
            
            mainNewsLabel.topAnchor.constraint(equalTo: stackViewHeader.bottomAnchor, constant: 15),
            mainNewsLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
            todayDateLabel.centerYAnchor.constraint(equalTo: mainNewsLabel.centerYAnchor),
            todayDateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
        ])
    }
    
    func applyAdditionalChanges() {
        self.backgroundColor = UIColor(named:"backgroundColor")
    }
    
    
}
