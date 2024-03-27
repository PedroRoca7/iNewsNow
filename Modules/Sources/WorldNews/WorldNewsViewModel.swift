//
//  WorldNewsViewModel.swift
//  INewsNow
//
//  Created by Pedro Henrique on 05/02/24.
//

import Foundation
import UIKit
import INewsNowCore
import Service


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

enum TypeNews {
    case mainNews, mostPopularNews
}

final class WorldNewsViewModel: WorldNewsViewModeling {
    
    private var service: NewYorkTimesServicing
    private var coordinator: WorldNewsCoordinating
    private(set) var mainNewsList: MainNewsModel?
    private(set) var mostPopularPostList: MostPopularNewsModel?
    private var coreDataService: CoreDataHelperService
    weak var delegate: WorldNewsViewModelDelegate?
    
    init(service: NewYorkTimesServicing, coordinator: WorldNewsCoordinating, coreDataService: CoreDataHelperService) {
        self.service = service
        self.coordinator = coordinator
        self.coreDataService = coreDataService
    }
    
    func loadMainNews() {
        Task {
            do {
                mainNewsList = try await service.loadMainNews()
            } catch {
                print("Erro ao buscar dados \(error.localizedDescription)")
                delegate?.failure()
            }
            delegate?.success()
        }
    }
    
    func loadMostPopularPost() {
        service.loadMostPopularNews { [weak self]  (data: MostPopularNewsModel?, error) in
            guard let self else { return }
            if let error = error {
                self.delegate?.failure()
                print(error.localizedDescription)
            } else if let data = data {
                self.mostPopularPostList = data
                self.delegate?.success()
            }
        }
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
                coreDataService.saveObjectToCoreData(object: newsData)
            } else {
                coreDataService.removeFavoritedNewsCoreData(id: news.id)
            }
        }
        if let news = newsData as? PopularNewsData {
            if news.favorite {
                coreDataService.saveObjectToCoreData(object: newsData)
            } else {
                coreDataService.removeFavoritedNewsCoreData(id: news.id)
            }
        }
    }
}
