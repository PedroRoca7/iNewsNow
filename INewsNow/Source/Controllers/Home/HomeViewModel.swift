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

final class HomeViewModel {
    
    enum TypeNews {
        case mainNews, mostPopularNews
    }
    
    private let service = NewYorkTimesService()
    private(set) var mainNewsList: MainNewsModel?
    private(set) var mostPopularPostList: MostPopularNewsModel?
    weak var delegate: HomeViewModelDelegate?

    
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
        case .mostPopularNews:
            mostPopularPostList?.results[index].favorite = !hasFavoritedMostPopular
        }
    }
}
