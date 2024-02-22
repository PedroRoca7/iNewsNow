//
//  DetailsNewsView.swift
//  INewsNow
//
//  Created by Pedro Henrique on 21/02/24.
//

import Foundation
import UIKit

final class DetailsNewsView: UIView {
    
    //MARK: Propertys
    
    private lazy var safeGuide = self.safeAreaLayoutGuide
    
    //MARK: ElementsVisual
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var viewScrollView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var imageNewsImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        return image
    }()
    
    lazy var titleNewsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 22)
        label.textColor = .black
        return label
    }()
    
    lazy var textDescriptionNewsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
        
    //MARK: Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DetailsNewsView: ViewProtocol {
    func buildHierarchy() {
        self.addSubview(scrollView)
        scrollView.addSubview(viewScrollView)
        viewScrollView.addSubview(imageNewsImageView)
        viewScrollView.addSubview(titleNewsLabel)
        viewScrollView.addSubview(textDescriptionNewsLabel)
    }
    
    func setupConstraints() {
       
        let scrollContentGuide = scrollView.contentLayoutGuide
        let scrollFramGuide = scrollView.frameLayoutGuide
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            viewScrollView.topAnchor.constraint(equalTo: scrollContentGuide.topAnchor),
            viewScrollView.leadingAnchor.constraint(equalTo: scrollContentGuide.leadingAnchor),
            viewScrollView.trailingAnchor.constraint(equalTo: scrollContentGuide.trailingAnchor),
            viewScrollView.bottomAnchor.constraint(equalTo: scrollContentGuide.bottomAnchor),
            
            viewScrollView.leadingAnchor.constraint(equalTo: scrollFramGuide.leadingAnchor),
            viewScrollView.trailingAnchor.constraint(equalTo: scrollFramGuide.trailingAnchor),
            
            imageNewsImageView.topAnchor.constraint(equalTo: viewScrollView.topAnchor),
            imageNewsImageView.leadingAnchor.constraint(equalTo: viewScrollView.leadingAnchor, constant: 5),
            imageNewsImageView.trailingAnchor.constraint(equalTo: viewScrollView.trailingAnchor, constant: -5),
            imageNewsImageView.heightAnchor.constraint(equalToConstant: 200),
            
            titleNewsLabel.topAnchor.constraint(equalTo: imageNewsImageView.bottomAnchor, constant: 10),
            titleNewsLabel.leadingAnchor.constraint(equalTo: viewScrollView.leadingAnchor, constant: 10),
            
            textDescriptionNewsLabel.topAnchor.constraint(equalTo: titleNewsLabel.bottomAnchor, constant: 10),
            textDescriptionNewsLabel.leadingAnchor.constraint(equalTo: viewScrollView.leadingAnchor, constant: 10),
            textDescriptionNewsLabel.trailingAnchor.constraint(equalTo: viewScrollView.trailingAnchor, constant: -10),
            textDescriptionNewsLabel.bottomAnchor.constraint(equalTo: viewScrollView.bottomAnchor, constant: -10),
        ])
    }
    
    func applyAdditionalChanges() {
        self.backgroundColor = .backgroundColor
    }
}
