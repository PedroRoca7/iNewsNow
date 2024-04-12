//
//  NewsBrasilView.swift
//  INewsNow
//
//  Created by Pedro Henrique on 20/02/24.
//

import Foundation
import UIKit

final class HomeView: UIView {
    
    //MARK: - Propertys
    
    private lazy var safeGuide = self.safeAreaLayoutGuide
    
    //MARK: - ElementsVisual
    
    lazy var newsTableView: UITableView = {
        let tb = UITableView()
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.backgroundColor = .clear
        tb.register(CustomNewsBrazilTableViewCell.self, forCellReuseIdentifier: CustomNewsBrazilTableViewCell.identifier)
        tb.clipsToBounds = true
        tb.showsVerticalScrollIndicator = false
        return tb
    }()
    
    lazy var loaderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    lazy var loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView(style: .large)
        loader.translatesAutoresizingMaskIntoConstraints = false
        return loader
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

extension HomeView: ViewProtocol {
    func buildHierarchy() {
        self.addSubview(newsTableView)
        self.addSubview(loaderView)
        loaderView.addSubview(loader)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            newsTableView.topAnchor.constraint(equalTo: safeGuide.topAnchor),
            newsTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            newsTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            newsTableView.bottomAnchor.constraint(equalTo: safeGuide.bottomAnchor),
            
            loaderView.topAnchor.constraint(equalTo: self.topAnchor),
            loaderView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            loaderView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            loaderView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            loader.centerXAnchor.constraint(equalTo: loaderView.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: loaderView.centerYAnchor),
        ])
    }
    
    func applyAdditionalChanges() {
        self.backgroundColor = .backgroundColor
    }
}
