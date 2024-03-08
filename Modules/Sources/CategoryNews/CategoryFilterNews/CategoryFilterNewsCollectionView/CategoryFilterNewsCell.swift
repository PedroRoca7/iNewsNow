//
//  MenuFilterNewsCell.swift
//  INewsNow
//
//  Created by Pedro Henrique on 05/03/24.
//

import Foundation
import UIKit
import INewsNowCore

final class CategoryFilterNewsCell: UIView {
    
    // MARK: - Propertys
    
    private lazy var guide = self.safeAreaLayoutGuide
    
    // MARK: - ElementsVisual
    
    lazy var imageCategory: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    lazy var categoryNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .black
        return label
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

extension CategoryFilterNewsCell: ViewProtocol {
    func buildHierarchy() {
        self.addSubview(imageCategory)
        self.addSubview(categoryNameLabel)
    }
    
    func setupConstraints() {
    
        NSLayoutConstraint.activate([
            imageCategory.topAnchor.constraint(equalTo: self.topAnchor),
            imageCategory.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageCategory.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageCategory.heightAnchor.constraint(equalToConstant: 80),
            
            categoryNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            categoryNameLabel.topAnchor.constraint(equalTo: imageCategory.bottomAnchor, constant: 5),
            categoryNameLabel.bottomAnchor.constraint(greaterThanOrEqualTo: self.bottomAnchor, constant: -5),
        ])
    }
    
    func applyAdditionalChanges() {
        self.backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 20
    }
}
