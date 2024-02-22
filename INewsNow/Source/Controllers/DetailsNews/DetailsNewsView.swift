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
    
    //MARK: ElementsVisual
    
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
        print("")
    }
    
    func setupConstraints() {
        print("")
    }
}
