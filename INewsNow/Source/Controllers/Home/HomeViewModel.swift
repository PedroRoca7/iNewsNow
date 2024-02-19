//
//  HomeViewModel.swift
//  INewsNow
//
//  Created by Pedro Henrique on 05/02/24.
//

import Foundation
import CoreData
import UIKit

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
    static var favoritedNewsArray: [NSManagedObject] = []
    weak var delegate: HomeViewModelDelegate?
    
    init(service: NewYorkTimesServicing, coordinator: HomeCoordinating) {
        self.service = service
        self.coordinator = coordinator
    }
    
    func loadMainNews() {
        service.loadMainNews { [weak self] data, error in
            guard let self else { return }
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
        service.loadMostPopularNews { [weak self] data, error in
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
    
    func showScreenWebViewController(webSiteNews: String) {
        coordinator.showScreenWebViewController(webSiteNews: webSiteNews)
    }
    
    private func appendOrRemoveFavoritesNewsArray(newsData: Any) {
        if let news = newsData as? NewsData {
            if news.favorite {
                saveMainNewsCoreData(mainNewsData: news)
            } else {
                removeFavoritedNewsCoreData(id: news.id)
            }
        }
        if let news = newsData as? PopularNewsData {
            if news.favorite {
                saveMostPopularNewsCoreData(mostPopularNews: news)
            } else {
                removeFavoritedNewsCoreData(id: news.id)
            }
        }
    }
    
    private func saveMainNewsCoreData(mainNewsData: NewsData) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "FavoriteNews", in: managedContext)
        if let entity {
            let favoriteNews = NSManagedObject(entity: entity, insertInto: managedContext)
            favoriteNews.setValue(mainNewsData.id, forKey: "id")
            favoriteNews.setValue(mainNewsData.title, forKey: "title")
            favoriteNews.setValue(mainNewsData.byline, forKey: "byline")
            favoriteNews.setValue(mainNewsData.url, forKey: "url")
            favoriteNews.setValue(mainNewsData.publishedDate, forKey: "publishedDate")
            favoriteNews.setValue(mainNewsData.favorite, forKey: "favorite")
            favoriteNews.setValue(mainNewsData.multimedia?.first?.url, forKey: "urlImage")
            
            do {
                try managedContext.save()
                HomeViewModel.favoritedNewsArray.append(favoriteNews)
            } catch let error as NSError {
                print("Falha ao salvar os dados no banco \(error.localizedDescription)")
            }
        }
    }
    
    private func saveMostPopularNewsCoreData(mostPopularNews: PopularNewsData) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "FavoriteNews", in: managedContext)
        if let entity {
            let favoriteNews = NSManagedObject(entity: entity, insertInto: managedContext)
            favoriteNews.setValue(mostPopularNews.id, forKey: "id")
            favoriteNews.setValue(mostPopularNews.title, forKey: "title")
            favoriteNews.setValue(mostPopularNews.byline, forKey: "byline")
            favoriteNews.setValue(mostPopularNews.url, forKey: "url")
            favoriteNews.setValue(mostPopularNews.publishedDate, forKey: "publishedDate")
            favoriteNews.setValue(mostPopularNews.favorite, forKey: "favorite")
            favoriteNews.setValue(mostPopularNews.media?.first?.mediaMetadata?.first?.url, forKey: "urlImage")
            
            do {
                try managedContext.save()
                HomeViewModel.favoritedNewsArray.append(favoriteNews)
            } catch let error as NSError {
                print("Falha ao salvar os dados no banco \(error.localizedDescription)")
            }
        }
    }
    
    private func removeFavoritedNewsCoreData(id: UUID) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteNews")
        
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            
            for object in results {
                managedContext.delete(object)
            }
            
            try managedContext.save()
        } catch let error as NSError {
            print("Erro ao deletar dados do banco \(error.localizedDescription)")
        }
    }
    
}
