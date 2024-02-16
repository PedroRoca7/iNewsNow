//
//  ScreenWebView.swift
//  INewsNow
//
//  Created by Pedro Henrique on 15/02/24.
//

import Foundation
import UIKit
import WebKit

final class ScreenWebView: UIView {
    
    // MARK: Propertys
    
    private lazy var safeGuide = self.safeAreaLayoutGuide
    
    lazy var webView: WKWebView = {
        let web = WKWebView()
        web.translatesAutoresizingMaskIntoConstraints = false
        return web
    }()
    
    lazy var loadingActivity: UIActivityIndicatorView = {
        let load = UIActivityIndicatorView()
        load.translatesAutoresizingMaskIntoConstraints = false
        return load
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

extension ScreenWebView: ViewProtocol {
    func buildHierarchy() {
        self.addSubview(webView)
        self.addSubview(loadingActivity)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: safeGuide.topAnchor),
            webView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            loadingActivity.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            loadingActivity.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
}
