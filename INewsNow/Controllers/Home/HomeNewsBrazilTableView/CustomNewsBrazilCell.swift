//
//  CustomNewsBrazilCell.swift
//  INewsNow
//
//  Created by Pedro Henrique on 20/02/24.
//

import Foundation
import UIKit

final class CustomNewsBrazilCell: UIView {
    
    //MARK: - Propertys
    
    private lazy var safeGuide = self.safeAreaLayoutGuide
    
    //MARK: - ElementsVisual
    
    lazy var imageNewsImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        return image
    }()
    
    lazy var titleNews: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.clipsToBounds = true
        return label
    }()
    
    lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12)
        label.textColor = .black
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12)
        label.textColor = .gray
        return label
        
    }()
    
    
    lazy var favoriteNewsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "heart.fill"),for: .normal)
        button.tintColor = .gray
        return button
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

extension CustomNewsBrazilCell: ViewProtocol {
    func buildHierarchy() {
        self.addSubview(imageNewsImageView)
        self.addSubview(titleNews)
        self.addSubview(favoriteNewsButton)
        self.addSubview(authorLabel)
        self.addSubview(dateLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageNewsImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            imageNewsImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            imageNewsImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            imageNewsImageView.heightAnchor.constraint(equalToConstant: 150),
            
            titleNews.topAnchor.constraint(equalTo: imageNewsImageView.bottomAnchor, constant: 5),
            titleNews.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            titleNews.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            
            favoriteNewsButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            favoriteNewsButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            favoriteNewsButton.widthAnchor.constraint(equalToConstant: 60),
            favoriteNewsButton.heightAnchor.constraint(equalToConstant: 60),
            
            authorLabel.topAnchor.constraint(greaterThanOrEqualTo: titleNews.bottomAnchor, constant: 3),
            authorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            authorLabel.trailingAnchor.constraint(greaterThanOrEqualTo: favoriteNewsButton.leadingAnchor, constant: -5),
            
            dateLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 3),
            dateLabel.leadingAnchor.constraint(equalTo: authorLabel.leadingAnchor),
            dateLabel.trailingAnchor.constraint(greaterThanOrEqualTo: favoriteNewsButton.leadingAnchor, constant: -5),
            dateLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -3),
        ])
    }
    
    func applyAdditionalChanges() {
        self.backgroundColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
