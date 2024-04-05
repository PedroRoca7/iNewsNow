//
//  FavoriteNewsViewModel.swift
//  INewsNow
//
//  Created by Pedro Henrique on 22/02/24.
//

import Foundation

protocol FavoriteNewsViewModeling {
    func showDetailsScreen<T>(newsObject: T)
}

final class FavoriteNewsViewModel: FavoriteNewsViewModeling {
    
    //MARK: Propertys
    
    var coordinator: FavoriteNewsCoordinating
    
    //MARK: Inits
    
    init(coordinator: FavoriteNewsCoordinating) {
        self.coordinator = coordinator
    }
    
    func showDetailsScreen<T>(newsObject: T) {
        coordinator.showScreenDetailsNews(newsObject: newsObject)
    }
}
