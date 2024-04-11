//
//  NewsBrazilViewModel.swift
//  INewsNow
//
//  Created by Pedro Henrique on 20/02/24.
//

import Foundation

protocol HomeViewModelDelegate: NSObject {
    func success()
    func failure()
}

protocol HomeViewModeling: AnyObject {
    func loadNewsBrazil()
    func showScreenNewsWorld()
    func setFavoriteNews(index: Int)
    func showScreenDetailsNews<T>(newsObject: T)
    func showScreenWeather()
    var delegate: HomeViewModelDelegate? { get set }
    var newsBrazilList: NewsBrazilModel? { get }
}

final class HomeViewModel: NSObject, HomeViewModeling {
    
    private var service: NewsBrazilDataIOServicing
    private var coordinator: HomeCoordinating
    private(set) var newsBrazilList: NewsBrazilModel?
    weak var delegate: HomeViewModelDelegate?
    
    init(service: NewsBrazilDataIOServicing, coordinator: HomeCoordinating) {
        self.service = service
        self.coordinator = coordinator
    }
    
    func loadNewsBrazil() {
        service.loadNewsBrazil()
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

extension HomeViewModel: NewsBrazilDataIOServiceDelegate {
    func didFailNewsBrazilFetching() {
        self.delegate?.failure()
    }
    
    func didSuccedNewsBrazilFetching(newsBrazil: NewsBrazilModel) {
        self.newsBrazilList = newsBrazil
        self.delegate?.success()
    }
}
