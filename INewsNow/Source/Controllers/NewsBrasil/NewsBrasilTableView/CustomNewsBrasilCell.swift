//
//  CustomNewsBrasilCell.swift
//  INewsNow
//
//  Created by Pedro Henrique on 20/02/24.
//

import Foundation
import UIKit

final class CustomNewsBrasilCell: UIView {
    
    //MARK: Propertys
    
    private lazy var safeGuide = self.safeAreaLayoutGuide
    
    //MARK: Elements Visual
    
    //MARK: Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomNewsBrasilCell: ViewProtocol {
    func buildHierarchy() {
        print("")
    }
    
    func setupConstraints() {
        print("")
    }
    
    func applyAdditionalChanges() {
        self.backgroundColor = .white
    }
}
