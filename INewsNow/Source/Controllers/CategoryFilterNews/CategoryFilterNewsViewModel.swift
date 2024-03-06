//
//  MenuFilterNewsViewModel.swift
//  INewsNow
//
//  Created by Pedro Henrique on 04/03/24.
//

import Foundation

protocol MenuFilterNewsViewModeling {
    func showScreenCategoryNews(titleCategory: String)
    var categorys: [String] { get }
}

final class MenuFilterNewsViewModel: MenuFilterNewsViewModeling {
        
    private(set) var categorys: [String] = ["Sports", "Technology",
                               "Business","Science",
                               "Entertainment", "Health",
                               "World", "Politics",
                               "Environment", "Food"]
    
    private var coordinator: MenuFilterNewsCoordinating
    
    init(coordinator: MenuFilterNewsCoordinating) {
        self.coordinator = coordinator
    }
    
    func showScreenCategoryNews(titleCategory: String) {
        coordinator.showScreenCategoryNews(titleCategory: titleCategory)
    }
}
