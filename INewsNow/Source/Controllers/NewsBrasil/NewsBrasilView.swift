//
//  NewsBrasilView.swift
//  INewsNow
//
//  Created by Pedro Henrique on 20/02/24.
//

import Foundation
import UIKit

final class NewsBrasilView: UIView {
    
    //MARK: Propertys
    
    private lazy var safeGuide = self.safeAreaLayoutGuide
    
    //MARK: Elements Visual
    
    lazy var newsTableView: UITableView = {
        let tb = UITableView()
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.backgroundColor = .clear
        tb.register(CustomNewsBrasilTableViewCell.self, forCellReuseIdentifier: CustomNewsBrasilTableViewCell.identifier)
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

extension NewsBrasilView: ViewProtocol {
    func buildHierarchy() {
        self.addSubview(newsTableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
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
