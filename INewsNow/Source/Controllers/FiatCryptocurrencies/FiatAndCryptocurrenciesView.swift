//
//  FiatAndCryptocurrenciesView.swift
//  INewsNow
//
//  Created by Pedro Henrique on 19/02/24.
//

import Foundation
import UIKit

final class FiatAndCryptocurrenciesView: UIView {
    
    // MARK: Propertys
    
    private lazy var safeGuide = self.safeAreaLayoutGuide
    
    // MARK: ElementsVisual
    
    lazy var searchBar: UISearchBar = {
        let search = UISearchBar()
        search.translatesAutoresizingMaskIntoConstraints = false
        return search
    }()
    
    lazy var cryptoTableView: UITableView = {
        let tb = UITableView()
        tb.translatesAutoresizingMaskIntoConstraints = false
        return tb
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

extension FiatAndCryptocurrenciesView: ViewProtocol {
    func buildHierarchy() {
        print("")
    }
    
    func setupConstraints() {
        print("")
    }
}
