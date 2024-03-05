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
    
    lazy var categoryNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textColor = .white
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

extension MenuFilterNewsCell: ViewProtocol {
    func buildHierarchy() {
        self.addSubview(categoryNameLabel)
    }
    
    func setupConstraints() {
    
        NSLayoutConstraint.activate([
            categoryNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            categoryNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
    
    func applyAdditionalChanges() {
        self.backgroundColor = .color1Red
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 20
    }
}
