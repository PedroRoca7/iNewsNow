//
//  MenuFilterNewsView.swift
//  INewsNow
//
//  Created by Pedro Henrique on 04/03/24.
//

import Foundation
import UIKit

final class CategoryFilterNewsView: UIView {
    
    //MARK: - Propertys
    
    lazy var safeGuide = self.safeAreaLayoutGuide
    
    //MARK: - ElementsVisual
    
    lazy var menuCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        let collecionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collecionView.translatesAutoresizingMaskIntoConstraints = false
        collecionView.backgroundColor = .clear
        collecionView.register(CategoryFilterNewsCollectionViewCell.self, forCellWithReuseIdentifier: CategoryFilterNewsCollectionViewCell.identifier)
        return collecionView
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

extension CategoryFilterNewsView: ViewProtocol {
    func buildHierarchy() {
        self.addSubview(menuCollectionView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            menuCollectionView.topAnchor.constraint(equalTo: safeGuide.topAnchor),
            menuCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            menuCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            menuCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }

    func applyAdditionalChanges() {
        self.backgroundColor = .backgroundColor
    }
}
