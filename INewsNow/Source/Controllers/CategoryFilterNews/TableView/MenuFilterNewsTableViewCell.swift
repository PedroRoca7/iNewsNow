//
//  MenuFilterNewsTableViewCell.swift
//  INewsNow
//
//  Created by Pedro Henrique on 05/03/24.
//

import Foundation
import UIKit

final class MenuFilterNewsTableViewCell: UITableViewCell {
    
    static let identifier: String = "MenuFilterNewsTableViewCell"
    
    private lazy var viewScreen: MenuFilterNewsCell = {
        let view = MenuFilterNewsCell()
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepareCollectionCell(titleCategory: String) {
        viewScreen.nameCategoryLabel.text = titleCategory
        viewScreen.backgroundImageView.image = UIImage(named: titleCategory) 
    }
    
}

extension MenuFilterNewsTableViewCell: ViewProtocol {
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
    func applyAdditionalChanges() {
        backgroundColor = .clear
        selectionStyle = .none
    }
}
