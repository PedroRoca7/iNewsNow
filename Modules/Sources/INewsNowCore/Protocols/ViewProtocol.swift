//
//  ViewProtocol.swift
//  INewsNow
//
//  Created by Pedro Henrique on 02/02/24.
//

import Foundation

public protocol ViewProtocol {
    func buildHierarchy()
    func setupConstraints()
    func applyAdditionalChanges()
}

public extension ViewProtocol {
    func setupView() {
        buildHierarchy()
        setupConstraints()
        applyAdditionalChanges()
    }
    
    func applyAdditionalChanges(){}
}
