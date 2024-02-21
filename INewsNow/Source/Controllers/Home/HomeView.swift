//
//  HomeView.swift
//  INewsNow
//
//  Created by Pedro Henrique on 31/01/24.
//

import Foundation
import UIKit

final class HomeView: UIView {
    
    // MARK: Propertys
    
    private lazy var safeGuide = self.safeAreaLayoutGuide
    
    // MARK: ElementsVisual
    
    lazy var sideMenuButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var logoImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.image = UIImage(named: "LogoINewsNowBottomless")
        return image
    }()
    
    lazy var newsPaperImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = UIColor.gray
        return image
    }()
    
    private lazy var headerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [sideMenuButton, logoImageView, newsPaperImage])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var mainNewsLabel: UILabel = {
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
        label.font = .boldSystemFont(ofSize: 10)
        label.textColor = .gray
        return label
    }()
    
    lazy var mainNewsCollectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout.init())
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .clear
        cv.register(CustomMainNewsCollectionViewCell.self,
                    forCellWithReuseIdentifier: CustomMainNewsCollectionViewCell.identifier)
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 330, height: 180)
        layout.minimumLineSpacing = 20
        cv.setCollectionViewLayout(layout, animated: false)
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    private lazy var mostPopularPostsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Most Popular Posts"
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    
    lazy var showAllPostsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("", for: .normal)
        button.setTitleColor(UIColor.gray, for: .normal)
        return button
    }()
    
    private lazy var mostPopularPostsAndshowAllPostsButtonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [mostPopularPostsLabel, showAllPostsButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    lazy var mostPopularPostsTableView: UITableView = {
        let tb = UITableView()
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.register(CustomMostPopularPostsTableViewCell.self,
                    forCellReuseIdentifier: CustomMostPopularPostsTableViewCell.identifier)
        tb.backgroundColor = .clear
        tb.clipsToBounds = true
        tb.showsVerticalScrollIndicator = false
        return tb
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
        self.addSubview(headerStackView)
        self.addSubview(mainNewsLabel)
        self.addSubview(todayDateLabel)
        self.addSubview(mainNewsCollectionView)
        self.addSubview(mostPopularPostsAndshowAllPostsButtonStackView)
        self.addSubview(mostPopularPostsTableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            sideMenuButton.widthAnchor.constraint(equalToConstant: 25),
            sideMenuButton.heightAnchor.constraint(equalToConstant: 25),
            
            newsPaperImage.widthAnchor.constraint(equalToConstant: 25),
            newsPaperImage.heightAnchor.constraint(equalToConstant: 25),
            
            headerStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 25),
            headerStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            headerStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            headerStackView.heightAnchor.constraint(equalToConstant: 70),
            
            mainNewsLabel.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 15),
            mainNewsLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
            todayDateLabel.centerYAnchor.constraint(equalTo: mainNewsLabel.centerYAnchor),
            todayDateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            
            mainNewsCollectionView.topAnchor.constraint(equalTo: mainNewsLabel.bottomAnchor, constant: 10),
            mainNewsCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            mainNewsCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            mainNewsCollectionView.heightAnchor.constraint(equalToConstant: 180),
            
            mostPopularPostsAndshowAllPostsButtonStackView.topAnchor.constraint(equalTo: mainNewsCollectionView.bottomAnchor
                                                                          , constant: 15),
            mostPopularPostsAndshowAllPostsButtonStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            mostPopularPostsAndshowAllPostsButtonStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            mostPopularPostsAndshowAllPostsButtonStackView.heightAnchor.constraint(equalToConstant: 30),
            
            mostPopularPostsTableView.topAnchor.constraint(equalTo: mostPopularPostsAndshowAllPostsButtonStackView.bottomAnchor, constant: 5),
            mostPopularPostsTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            mostPopularPostsTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            mostPopularPostsTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    func applyAdditionalChanges() {
        self.backgroundColor = .backgroundColor
    }
}
