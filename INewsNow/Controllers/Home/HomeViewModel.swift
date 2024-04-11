//
//  NewsBrazilViewModel.swift
//  INewsNow
//
//  Created by Pedro Henrique on 20/02/24.
//

import Foundation

protocol HomeViewModelDelegate: AnyObject {
    func success()
    func failure()
}

protocol HomeViewModeling {
    func loadNewsBrazil()
    func showScreenNewsWorld()
    func setFavoriteNews(index: Int)
    func showScreenDetailsNews<T>(newsObject: T)
    func showScreenWeather()
    var delegate: HomeViewModelDelegate? { get set }
    var newsBrazilList: NewsBrazilModel? { get }
}

final class HomeViewModel: HomeViewModeling {
    
    private var service: NewsBrazilDataIOService
    private var coordinator: HomeCoordinating
    private(set) var newsBrazilList: NewsBrazilModel?
    weak var delegate: HomeViewModelDelegate?
    
    init(service: NewsBrazilDataIOService, coordinator: HomeCoordinating) {
        self.service = service
        self.coordinator = coordinator
    }
    
    func loadNewsBrazil() {
        service.loadNewsBrazil { [weak self] data, error in
            guard let self else { return }
            if let error = error {
                self.delegate?.failure()
                print(error.localizedDescription)
            } else if let data = data {
                self.newsBrazilList = data
                self.delegate?.success()
            }
        }
    }
    
    func setFavoriteNews(index: Int) {
        guard let hasFavoritedNewsBrazil = newsBrazilList?.results[index].favorite else { return }
        newsBrazilList?.results[index].favorite = !hasFavoritedNewsBrazil
        guard let news = newsBrazilList?.results[index] else { return }
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
    
    func showScreenNewsWorld() {
        coordinator.showNewsWorld()
    }
    
    func showScreenWeather() {
        coordinator.showScreenWeather()
    }
}
