//
//  MenuFilterNewsView.swift
//  INewsNow
//
//  Created by Pedro Henrique on 04/03/24.
//

import Foundation
import UIKit

final class MenuFilterNewsView: UIView {
    
    //MARK: - Propertys
    
    lazy var safeGuide = self.safeAreaLayoutGuide
    
    //MARK: - ElementsVisual
    
    
    //MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MenuFilterNewsView: ViewProtocol {
    func buildHierarchy() {
        print("")
    }
    
    func setupConstraints() {
        print("")
    }

}
