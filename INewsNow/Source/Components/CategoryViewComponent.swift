//
//  CategoryViewComponent.swift
//  INewsNow
//
//  Created by Pedro Henrique on 01/04/24.
//

import UIKit

final class CategoryViewComponent: UIView {
    
    lazy var stackView: UIStackView = {
        let element = UIStackView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.alignment = .leading
        element.axis = .vertical
        element.spacing = 10
        element.isLayoutMarginsRelativeArrangement = true
        element.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
        return element
    }()
    
    lazy var backgroundImageView: UIImageView = {
        let element = UIImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.layer.cornerRadius = 10
        element.clipsToBounds = true
        element.heightAnchor.constraint(equalToConstant: 120).isActive = true
        element.image = UIImage(named: "NewYorkTimes")
        return element
    }()
    
    lazy var nameCategoryLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        element.textColor = .black
        element.text = "The New York Times"
        return element
    }()
    
    lazy var button: UIButton = {
        let element = UIButton()
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CategoryViewComponent: ViewProtocol {
    func buildHierarchy() {
        self.addSubview(stackView)
        self.addSubview(button)
        stackView.addArrangedSubview(backgroundImageView)
        stackView.addArrangedSubview(nameCategoryLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            button.topAnchor.constraint(equalTo: self.topAnchor),
            button.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            button.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}
