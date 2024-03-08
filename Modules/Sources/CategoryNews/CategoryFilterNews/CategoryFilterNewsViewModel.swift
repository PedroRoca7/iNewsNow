//
//  MenuFilterNewsViewModel.swift
//  INewsNow
//
//  Created by Pedro Henrique on 04/03/24.
//

import Foundation

protocol CategoryFilterNewsViewModeling {
    func showScreenCategoryNews(titleCategory: String)
    var categorys: [String] { get }
}

final class CategoryFilterNewsViewModel: CategoryFilterNewsViewModeling {
        
    private(set) var categorys: [String] = ["Sports", "Technology",
                               "Business","Science",
                               "Entertainment", "Health",
                               "World", "Politics",
                               "Environment", "Food"]
    
    private var coordinator: CategoryFilterNewsCoordinating
    
    init(coordinator: CategoryFilterNewsCoordinating) {
        self.coordinator = coordinator
    }
    
    func showScreenCategoryNews(titleCategory: String) {
        coordinator.showScreenCategoryNews(titleCategory: titleCategory)
    }
}
