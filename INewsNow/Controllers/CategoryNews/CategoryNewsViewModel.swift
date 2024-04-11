//
//  CategoryNewsViewModel.swift
//  INewsNow
//
//  Created by Pedro Henrique on 06/03/24.
//

import Foundation

protocol CategoryNewsViewModeling {
    func loadNewsCategory()
    func setFavoriteNews(index: Int)
    func showScreenDetailsNews<T>(newsObject: T)
    var titleCategory: String { get }
    var newsCategoryBrazilList: NewsBrazilModel? { get }
    var delegate: CategoryNewsViewModelDelegate? { get set }
}

protocol CategoryNewsViewModelDelegate: AnyObject {
    func success()
    func failure()
}

final class CategoryNewsViewModel: NSObject, CategoryNewsViewModeling {
    
    private var service: NewsBrazilDataIOServicing
    private var coordinator: CategoryNewsCoordinating
    private(set) var newsCategoryBrazilList: NewsBrazilModel?
    private(set) var titleCategory: String
    weak var delegate: CategoryNewsViewModelDelegate?
    
    init(service: NewsBrazilDataIOServicing, coordinator: CategoryNewsCoordinating, titleCategory: String) {
        self.service = service
        self.coordinator = coordinator
        self.titleCategory = titleCategory
    }
    
    func loadNewsCategory() {
        service.loadCategoryNewsBrazil(category: titleCategory)
    }
    
    func setFavoriteNews(index: Int) {
        guard let hasFavoritedCategoryNewsBrazil = newsCategoryBrazilList?.results[index].favorite else { return }
        newsCategoryBrazilList?.results[index].favorite = !hasFavoritedCategoryNewsBrazil
        guard let news = newsCategoryBrazilList?.results[index] else { return }
        appendOrRemoveFavoritesNewsArray(newsData: news)
        
    }

    private func appendOrRemoveFavoritesNewsArray(newsData: Any) {
        if let news = newsData as? Article {
            if news.favorite {
                CoreDataHelper.shared.saveObjectToCoreData(object: newsData)
            } else {
                CoreDataHelper.shared.removeFavoritedNewsCoreData(id: news.id)
            }
        }
    }
    
    func showScreenDetailsNews<T>(newsObject: T) {
        coordinator.showScreenDetailsNews(newsObject: newsObject)
    }
}

extension CategoryNewsViewModel: NewsBrazilDataIOServiceDelegate {
    func didFailNewsBrazilFetching() {
        self.delegate?.failure()
    }
    
    func didSuccedNewsBrazilFetching(newsBrazil: NewsBrazilModel) {
        self.newsCategoryBrazilList = newsBrazil
        self.delegate?.success()
    }
}
