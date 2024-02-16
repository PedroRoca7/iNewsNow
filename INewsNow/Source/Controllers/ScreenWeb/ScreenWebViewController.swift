//
//  ScreenWebViewController.swift
//  INewsNow
//
//  Created by Pedro Henrique on 15/02/24.
//

import Foundation
import UIKit
import WebKit

final class ScreenWebViewController: UIViewController {
    
    lazy var viewScreen: ScreenWebView = {
        let view = ScreenWebView()
        return view
    }()
    
    private var webSiteNews: String
    
    init(webSiteNews: String) {
        self.webSiteNews = webSiteNews
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = viewScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        viewScreen.loadingActivity.startAnimating()
        loadWebSite()
    }
    
    private func setupNavigationController() {
        navigationController?.navigationBar.tintColor = UIColor(named: "backgroundColor")
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    private func loadWebSite() {
        guard let url = URL(string: webSiteNews) else { return }
        let request = URLRequest(url: url)
        viewScreen.webView.allowsBackForwardNavigationGestures = true
        viewScreen.webView.allowsLinkPreview = true
        viewScreen.webView.navigationDelegate = self
        viewScreen.webView.uiDelegate = self
        DispatchQueue.main.async {
            self.viewScreen.webView.load(request)
        }
    }
}

extension ScreenWebViewController: WKNavigationDelegate, WKUIDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        DispatchQueue.main.async {
            self.viewScreen.loadingActivity.stopAnimating()
        }
    }
}
