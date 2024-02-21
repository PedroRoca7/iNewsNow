//
//  CustomMainNewsCell.swift
//  INewsNow
//
//  Created by Pedro Henrique on 02/02/24.
//

import UIKit

final class CustomMainNewsCell: UIView {
    
    // MARK: Propertys
    
    private lazy var guide = self.safeAreaLayoutGuide
    
    // MARK: ElementsVisual
    
    lazy var backgroundImageNewsImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        image.alpha = 0.4
        return image
    }()
    
    lazy var dateNewsLabel: UILabel = {
        let label =  UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Nov. 13, 2019"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .lightGray
        return label
    }()
    
    lazy var favoriteNewsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        return button
    }()
    
    lazy var newsTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "GitHub launches a mobile app, smarter notifications and improved code search"
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    lazy var authorNewsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Frederic Lardinois"
        label.font = .boldSystemFont(ofSize: 12)
        label.textColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.clipsToBounds = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CustomMainNewsCell: ViewProtocol {
    func buildHierarchy() {
        self.addSubview(backgroundImageNewsImageView)
        self.addSubview(dateNewsLabel)
        self.addSubview(favoriteNewsButton)
        self.addSubview(newsTextLabel)
        self.addSubview(authorNewsLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageNewsImageView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundImageNewsImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundImageNewsImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backgroundImageNewsImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            dateNewsLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            dateNewsLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            
            favoriteNewsButton.centerYAnchor.constraint(equalTo: dateNewsLabel.centerYAnchor),
            favoriteNewsButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            favoriteNewsButton.heightAnchor.constraint(equalToConstant: 40),
            favoriteNewsButton.widthAnchor.constraint(equalToConstant: 40),
            
            newsTextLabel.topAnchor.constraint(equalTo: dateNewsLabel.bottomAnchor, constant: 5),
            newsTextLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            newsTextLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            authorNewsLabel.topAnchor.constraint(greaterThanOrEqualTo: newsTextLabel.bottomAnchor, constant: 5),
            authorNewsLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            authorNewsLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            authorNewsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
        ])
    }
    
    func applyAdditionalChanges() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .black
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
}

