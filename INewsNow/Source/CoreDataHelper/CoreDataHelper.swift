//
//  CoreDataHelper.swift
//  INewsNow
//
//  Created by Pedro Henrique on 21/02/24.
//

import Foundation
import UIKit
import CoreData

final class CoreDataHelper {
    static let shared = CoreDataHelper()
    
    private(set) var dbCoreDataFavoriteNews: [NSManagedObject] = []
    
    private init() {}
    
    func saveObjectToCoreData<T>(object: T) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "FavoriteNews", in: managedContext)
        if let entity {
            let managedObject = NSManagedObject(entity: entity, insertInto: managedContext)
            
            if let newsBrazil  = object as? Article {
                managedObject.setValue(newsBrazil.id, forKey: "id")
                managedObject.setValue(newsBrazil.title, forKey: "title")
                managedObject.setValue(newsBrazil.sourceId, forKey: "byline")
                managedObject.setValue(newsBrazil.imageURL, forKey: "urlImage")
                managedObject.setValue(newsBrazil.pubDate, forKey: "publishedDate")
                managedObject.setValue(newsBrazil.favorite, forKey: "favorite")
            } else if let mainNewsNewYorkTime = object as? NewsData {
                managedObject.setValue(mainNewsNewYorkTime.id, forKey: "id")
                managedObject.setValue(mainNewsNewYorkTime.title, forKey: "title")
                managedObject.setValue(mainNewsNewYorkTime.byline, forKey: "byline")
                managedObject.setValue(mainNewsNewYorkTime.multimedia.first?.url, forKey: "urlImage")
                managedObject.setValue(mainNewsNewYorkTime.publishedDate, forKey: "publishedDate")
                managedObject.setValue(mainNewsNewYorkTime.favorite, forKey: "favorite")
            } else if let mostPopularNewsNewYorkTime = object as? PopularNewsData {
                managedObject.setValue(mostPopularNewsNewYorkTime.id, forKey: "id")
                managedObject.setValue(mostPopularNewsNewYorkTime.title, forKey: "title")
                managedObject.setValue(mostPopularNewsNewYorkTime.byline, forKey: "byline")
                managedObject.setValue(mostPopularNewsNewYorkTime.media.first?.mediaMetadata.first?.url, forKey: "urlImage")
                managedObject.setValue(mostPopularNewsNewYorkTime.publishedDate, forKey: "publishedDate")
                managedObject.setValue(mostPopularNewsNewYorkTime.favorite, forKey: "favorite")
            }
            
            do {
                try managedContext.save()
                CoreDataHelper.shared.dbCoreDataFavoriteNews.append(managedObject)
            } catch let error as NSError {
                print("Falha ao salvar os dados no banco \(error.localizedDescription)")
            }
        }
    }
    
    func removeFavoritedNewsCoreData(id: UUID) {
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
    
    func getFavoriteNewsDB() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteNews")
        
        do {
            CoreDataHelper.shared.dbCoreDataFavoriteNews = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Erro ao carregar dados do banco \(error.localizedDescription)")
        }
    }
    
    func removeFavoritedNews(test: Int) {
        CoreDataHelper.shared.dbCoreDataFavoriteNews.remove(at: test)
    }
}
