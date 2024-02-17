//
//  CustomFavoriteNewsCell.swift
//  INewsNow
//
//  Created by Pedro Henrique on 16/02/24.
//

import Foundation
import UIKit

final class CustomFavoriteNewsCell: UIView {
 
    // MARK: Propertys
    
    private lazy var safeGuide = self.safeAreaLayoutGuide
    
    // MARK: ElementsVisual
    
    lazy var textNewsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    lazy var authorNewsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Frederic Lardinois"
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.clipsToBounds = true
        return label
    }()
    
    lazy var favoriteNewsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "heart.fill"),for: .normal)
        button.tintColor = .red
        return button
    }()
    
    lazy var dateNewsLabel: UILabel = {
        let label =  UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Nov. 13, 2019"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    lazy var imageNewsImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        return image
    }()
    
    
    // MARK: Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CustomFavoriteNewsCell: ViewProtocol {
    func buildHierarchy() {
        self.addSubview(imageNewsImageView)
        self.addSubview(textNewsLabel)
        self.addSubview(favoriteNewsButton)
        self.addSubview(authorNewsLabel)
        self.addSubview(dateNewsLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageNewsImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 3),
            imageNewsImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -3),
            imageNewsImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -3),
            imageNewsImageView.widthAnchor.constraint(equalToConstant: 150),
            
            textNewsLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            textNewsLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            textNewsLabel.trailingAnchor.constraint(equalTo: imageNewsImageView.leadingAnchor, constant: -5),
            
            favoriteNewsButton.topAnchor.constraint(greaterThanOrEqualTo: self.textNewsLabel.bottomAnchor, constant: 5),
            favoriteNewsButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            favoriteNewsButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            favoriteNewsButton.heightAnchor.constraint(equalToConstant: 60),
            favoriteNewsButton.widthAnchor.constraint(equalToConstant: 60),
            
            authorNewsLabel.leadingAnchor.constraint(equalTo: favoriteNewsButton.trailingAnchor, constant: 5),
            authorNewsLabel.trailingAnchor.constraint(equalTo: imageNewsImageView.leadingAnchor, constant: -5),
            
            dateNewsLabel.topAnchor.constraint(equalTo: authorNewsLabel.bottomAnchor, constant: 2),
            dateNewsLabel.leadingAnchor.constraint(equalTo: favoriteNewsButton.trailingAnchor, constant: 5),
            dateNewsLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            dateNewsLabel.trailingAnchor.constraint(equalTo: imageNewsImageView.leadingAnchor, constant: -5),
        ])
    }
    
    func applyAdditionalChanges() {
        self.backgroundColor = .backgroundColor
        self.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = true
    }
}
