//
//  MenuFilterNewsView.swift
//  INewsNow
//
//  Created by Pedro Henrique on 04/03/24.
//

import Foundation
import UIKit

final class MenuFilterNewsView: UIView {
        
    //MARK: - ElementsVisual
    
    lazy var scrollView: SimpleScrollView = {
        let element = SimpleScrollView(spacing: 10, margins: .init(top: 10, leading: 10, bottom: 10, trailing: 10))
        element.showsVerticalScrollIndicator = false
        element.translatesAutoresizingMaskIntoConstraints = false
        element.bounces = false
        return element
    }()
    
    lazy var newYorkTimesButtonCategory: CategoryViewComponent = {
        let element = CategoryViewComponent()
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    lazy var menuTableView: UITableView = {
        let element = UITableView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = .clear
        element.separatorColor = .clear
        element.heightAnchor.constraint(greaterThanOrEqualToConstant: 1000).isActive = true
        element.showsVerticalScrollIndicator = false
        element.bounces = true
        element.register(MenuFilterNewsTableViewCell.self, forCellReuseIdentifier: MenuFilterNewsTableViewCell.identifier)
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

extension MenuFilterNewsView: ViewProtocol {
    func buildHierarchy() {
        self.addSubview(scrollView)
        scrollView.addSubview(newYorkTimesButtonCategory)
        scrollView.addSubview(menuTableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }

    func applyAdditionalChanges() {
        self.backgroundColor = .backgroundColor
    }
}
