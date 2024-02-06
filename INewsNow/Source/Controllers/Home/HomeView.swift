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
    
    lazy var searchController = UISearchController(searchResultsController: nil)
    
    lazy var floatingMenuButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "car"), for: .normal)
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
    
    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "car"), for: .normal)
        return button
    }()
    
    private lazy var headerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [floatingMenuButton, logoImageView, searchButton])
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
    
    private lazy var todayPostsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Today's Posts"
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    
    lazy var showAllPostsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("See all", for: .normal)
        button.setTitleColor(UIColor.gray, for: .normal)
        return button
    }()
    
    private lazy var todayPostsAndshowAllPostsButtonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [todayPostsLabel, showAllPostsButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    lazy var todayPostsTableView: UITableView = {
        let tb = UITableView()
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.register(CustomTodayPostsTableViewCell.self,
                    forCellReuseIdentifier: CustomTodayPostsTableViewCell.identifier)
        tb.backgroundColor = .clear
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
        self.addSubview(todayPostsAndshowAllPostsButtonStackView)
        self.addSubview(todayPostsTableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            floatingMenuButton.widthAnchor.constraint(equalToConstant: 25),
            floatingMenuButton.heightAnchor.constraint(equalToConstant: 25),
            
            searchButton.widthAnchor.constraint(equalToConstant: 25),
            searchButton.heightAnchor.constraint(equalToConstant: 25),
            
            headerStackView.topAnchor.constraint(equalTo: safeGuide.topAnchor),
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
            
            todayPostsAndshowAllPostsButtonStackView.topAnchor.constraint(equalTo: mainNewsCollectionView.bottomAnchor
                                                                          , constant: 15),
            todayPostsAndshowAllPostsButtonStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            todayPostsAndshowAllPostsButtonStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            todayPostsAndshowAllPostsButtonStackView.heightAnchor.constraint(equalToConstant: 30),
            
            todayPostsTableView.topAnchor.constraint(equalTo: todayPostsAndshowAllPostsButtonStackView.bottomAnchor, constant: 5),
            todayPostsTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            todayPostsTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            todayPostsTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func applyAdditionalChanges() {
        self.backgroundColor = UIColor(named:"backgroundColor")
    }
}
