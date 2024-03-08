//
//  MenuFilterNewsCollectionViewCell.swift
//  INewsNow
//
//  Created by Pedro Henrique on 05/03/24.
//

import Foundation
import UIKit
import INewsNowCore

final class CategoryFilterNewsCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "CategoryFilterNewsCollectionViewCell"
    
    private lazy var viewScreen: CategoryFilterNewsCell = {
        let view = CategoryFilterNewsCell()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepareCollectionCell(titleCategory: String) {
        viewScreen.imageCategory.image = UIImage(named: titleCategory)
        viewScreen.categoryNameLabel.text = titleCategory
    }
    
}

extension CategoryFilterNewsCollectionViewCell: ViewProtocol {
    
    func buildHierarchy() {
        contentView.addSubview(viewScreen)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            viewScreen.topAnchor.constraint(equalTo: self.topAnchor),
            viewScreen.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            viewScreen.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            viewScreen.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
