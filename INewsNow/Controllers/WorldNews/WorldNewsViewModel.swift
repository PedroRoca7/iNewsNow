//
//  HomeViewModel.swift
//  INewsNow
//
//  Created by Pedro Henrique on 05/02/24.
//

import Foundation
import UIKit

protocol WorldNewsViewModelDelegate: AnyObject {
    func success()
    func failure()
}

protocol WorldNewsViewModeling {
    func loadMainNews()
    func loadMostPopularPost()
    func setFavoriteNews(index: Int, typeNews: TypeNews)
    func showScreenDetailsNews<T>(newsObject: T)
    var delegate: WorldNewsViewModelDelegate? { get set }
    var mainNewsList: MainNewsModel? { get }
    var mostPopularPostList: MostPopularNewsModel? { get }
}



final class WorldNewsViewModel: NSObject, WorldNewsViewModeling {
    
    private var service: NewYorkTimesServicing
    private var coordinator: WorldNewsCoordinating
    private(set) var mainNewsList: MainNewsModel?
    private(set) var mostPopularPostList: MostPopularNewsModel?
    weak var delegate: WorldNewsViewModelDelegate?
    
    init(service: NewYorkTimesServicing, coordinator: WorldNewsCoordinating) {
        self.service = service
        self.coordinator = coordinator
    }
    
    func loadMainNews() {
        service.loadMainNews()
    }
    
    func loadMostPopularPost() {
        service.loadMostPopularNews()
    }
    
    func setFavoriteNews(index: Int, typeNews: TypeNews) {
        guard let hasFavoritedMainNews = mainNewsList?.results[index].favorite,
              let hasFavoritedMostPopular = mostPopularPostList?.results[index].favorite else { return }
        
        switch typeNews {
        case .mainNews:
            mainNewsList?.results[index].favorite = !hasFavoritedMainNews
            guard let news = mainNewsList?.results[index] else { return }
            appendOrRemoveFavoritesNewsArray(newsData: news)
        case .mostPopularNews:
            mostPopularPostList?.results[index].favorite = !hasFavoritedMostPopular
            guard let news = mostPopularPostList?.results[index] else { return }
            appendOrRemoveFavoritesNewsArray(newsData: news)
        }
    }
    
    func showScreenDetailsNews<T>(newsObject: T) {
        coordinator.showScreenDetailsNews(newsObject: newsObject)
    }
            
    private func appendOrRemoveFavoritesNewsArray(newsData: Any) {
        if let news = newsData as? NewsData {
            if news.favorite {
                CoreDataHelper.shared.saveObjectToCoreData(object: newsData)
            } else {
                CoreDataHelper.shared.removeFavoritedNewsCoreData(id: news.id)
            }
        }
        if let news = newsData as? PopularNewsData {
            if news.favorite {
                CoreDataHelper.shared.saveObjectToCoreData(object: newsData)
            } else {
                CoreDataHelper.shared.removeFavoritedNewsCoreData(id: news.id)
            }
        }
    }
}

extension WorldNewsViewModel: NewYorkTimesServiceDelegate {
    func didFailMainNewsFetching() {
        self.delegate?.failure()
    }
    
    func didSuccedMainNewsFetching(mainNews: MainNewsModel) {
        self.mainNewsList = mainNews
        self.delegate?.success()
    }
    
    func didFailMostPopularFetching() {
        self.delegate?.failure()
    }
    
    func didSuccedMostPopularFetching(mostPopular: MostPopularNewsModel) {
        self.mostPopularPostList = mostPopular
        self.delegate?.success()
    }
}
