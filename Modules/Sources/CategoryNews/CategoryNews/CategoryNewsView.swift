//
//  CategoryNewsView.swift
//  INewsNow
//
//  Created by Pedro Henrique on 06/03/24.
//

import Foundation
import UIKit
import INewsNowCore

final class CategoryNewsView: UIView {
    
    //MARK: - Propertys
    
    private lazy var safeGuide = self.safeAreaLayoutGuide
    
    //MARK: - ElementsVisual
    
    lazy var categoryNewsTableView: UITableView = {
        let tb = UITableView()
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.backgroundColor = .clear
        tb.register(CategoryNewsTableViewCell.self, forCellReuseIdentifier: CategoryNewsTableViewCell.identifier)
        tb.clipsToBounds = true
        tb.showsVerticalScrollIndicator = false
        return tb
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

extension CategoryNewsView: ViewProtocol {
    func buildHierarchy() {
        self.addSubview(categoryNewsTableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            categoryNewsTableView.topAnchor.constraint(equalTo: safeGuide.topAnchor),
            categoryNewsTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            categoryNewsTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            categoryNewsTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    func applyAdditionalChanges() {
        self.backgroundColor = .backgroundColor
    }
}
