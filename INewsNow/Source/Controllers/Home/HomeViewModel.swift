//
//  HomeViewModel.swift
//  INewsNow
//
//  Created by Pedro Henrique on 05/02/24.
//

import Foundation

protocol HomeViewModelDelegate: AnyObject {
    func success()
    func failure()
}

protocol HomeViewModeling {
    func loadMainNews()
    func loadMostPopularPost()
    func setFavoriteNews(index: Int, typeNews: TypeNews)
    func showScreenWebViewController(webSiteNews: String)
    var delegate: HomeViewModelDelegate? { get set }
    var mainNewsList: MainNewsModel? { get }
    var mostPopularPostList: MostPopularNewsModel? { get }
}

enum TypeNews {
    case mainNews, mostPopularNews
}

final class HomeViewModel: HomeViewModeling {
    
    private var service: NewYorkTimesServicing
    private var coordinator: HomeCoordinating
    private(set) var mainNewsList: MainNewsModel?
    private(set) var mostPopularPostList: MostPopularNewsModel?
    static var favoritedNewsArray: [NewsProtocol] = []
    weak var delegate: HomeViewModelDelegate?

    init(service: NewYorkTimesServicing, coordinator: HomeCoordinating) {
        self.service = service
        self.coordinator = coordinator
    }
    
    func loadMainNews() {
        service.loadMainNews { data, error in
            if let error = error {
                self.delegate?.failure()
                print(error.localizedDescription)
            } else if let data = data {
                self.mainNewsList = data
                self.delegate?.success()
            }
        }
    }
    
    func loadMostPopularPost() {
        service.loadMostPopularNews { data, error in
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
    
    func showScreenWebViewController(webSiteNews: String) {
        coordinator.showScreenWebViewController(webSiteNews: webSiteNews)
    }
    
    private func appendOrRemoveFavoritesNewsArray(newsData: NewsProtocol) {
        if newsData.favorite {
            HomeViewModel.favoritedNewsArray.append(newsData)
            print(HomeViewModel.favoritedNewsArray.count)
        } else {
            HomeViewModel.favoritedNewsArray = HomeViewModel.favoritedNewsArray.filter { $0.id != newsData.id}
            print(HomeViewModel.favoritedNewsArray.count)
        }
    }
}
