//
//  NewsBrasilView.swift
//  INewsNow
//
//  Created by Pedro Henrique on 20/02/24.
//

import Foundation
import UIKit
import JJFloatingActionButton

final class HomeView: UIView {
    
    //MARK: Propertys
    
    private lazy var safeGuide = self.safeAreaLayoutGuide
    
    //MARK: Elements Visual
    
    lazy var menuFloatingButton: JJFloatingActionButton = {
        let button = JJFloatingActionButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.buttonDiameter = 45
        button.buttonColor = .color1Red ?? .red
        button.itemAnimationConfiguration = .slideIn()
        button.configureDefaultItem { item in
            item.titleLabel.font = .boldSystemFont(ofSize: UIFont.systemFontSize)
            item.titleLabel.backgroundColor = .color1Red
        }
        return button
    }()
    
    lazy var newsTableView: UITableView = {
        let tb = UITableView()
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.backgroundColor = .clear
        tb.register(CustomNewsBrazilTableViewCell.self, forCellReuseIdentifier: CustomNewsBrazilTableViewCell.identifier)
        tb.clipsToBounds = true
        tb.showsVerticalScrollIndicator = false
        return tb
    }()
    
    //MARK: Inits
    
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
        self.addSubview(newsTableView)
        self.addSubview(menuFloatingButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            menuFloatingButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -45),
            menuFloatingButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            
            newsTableView.topAnchor.constraint(equalTo: safeGuide.topAnchor),
            newsTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            newsTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            newsTableView.bottomAnchor.constraint(equalTo: safeGuide.bottomAnchor),
        ])
    }
    
    func applyAdditionalChanges() {
        self.backgroundColor = .backgroundColor
    }
}
