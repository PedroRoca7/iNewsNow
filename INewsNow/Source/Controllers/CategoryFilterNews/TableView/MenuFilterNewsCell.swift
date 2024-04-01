//
//  MenuFilterNewsCell.swift
//  INewsNow
//
//  Created by Pedro Henrique on 05/03/24.
//

import Foundation
import UIKit

final class MenuFilterNewsCell: UIView {
    
    // MARK: - Propertys
    
    private lazy var guide = self.safeAreaLayoutGuide
    
    // MARK: - ElementsVisual
    
    lazy var stackView: UIStackView = {
        let element = UIStackView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.alignment = .leading
        element.axis = .vertical
        element.spacing = 5
        element.isLayoutMarginsRelativeArrangement = true
        element.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        return element
    }()
    
    lazy var backgroundImageView: UIImageView = {
        let element = UIImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.layer.cornerRadius = 10
        element.clipsToBounds = true
        element.heightAnchor.constraint(equalToConstant: 100).isActive = true
        return element
    }()
    
    lazy var nameCategoryLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        element.textColor = .black
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

extension MenuFilterNewsCell: ViewProtocol {
    func buildHierarchy() {
        self.addSubview(stackView)
        stackView.addArrangedSubview(backgroundImageView)
        stackView.addArrangedSubview(nameCategoryLabel)
    }
    
    func setupConstraints() {
    
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    func applyAdditionalChanges() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
    }
}
