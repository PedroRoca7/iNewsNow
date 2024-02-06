//
//  ViewProtocol.swift
//  INewsNow
//
//  Created by Pedro Henrique on 02/02/24.
//

import Foundation

protocol ViewProtocol {
    func buildHierarchy()
    func setupConstraints()
    func applyAdditionalChanges()
}

extension ViewProtocol {
    func setupView() {
        buildHierarchy()
        setupConstraints()
        applyAdditionalChanges()
    }
    
    func applyAdditionalChanges(){}
}



