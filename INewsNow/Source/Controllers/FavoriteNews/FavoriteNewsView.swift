//
//  FavoriteNewsView.swift
//  INewsNow
//
//  Created by Pedro Henrique on 16/02/24.
//

import Foundation
import UIKit

final class FavoriteNewsView: UIView {
    
    // MARK: - Propretys
    
    private lazy var safeGuide = self.safeAreaLayoutGuide
    
    //MARK: - ElementsVisual
    
    lazy var favoriteNewsTableView: UITableView = {
        let tb = UITableView()
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.register(CustomFavoriteNewsTableViewCell.self,
                    forCellReuseIdentifier: CustomFavoriteNewsTableViewCell.identifier)
        tb.backgroundColor = .clear
        tb.clipsToBounds = true
        tb.showsVerticalScrollIndicator = false
        return tb
    }()
    
    // MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension FavoriteNewsView: ViewProtocol {
    func buildHierarchy() {
        self.addSubview(favoriteNewsTableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            favoriteNewsTableView.topAnchor.constraint(equalTo: safeGuide.topAnchor),
            favoriteNewsTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            favoriteNewsTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            favoriteNewsTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    func applyAdditionalChanges() {
        self.backgroundColor = .backgroundColor
    }
}
