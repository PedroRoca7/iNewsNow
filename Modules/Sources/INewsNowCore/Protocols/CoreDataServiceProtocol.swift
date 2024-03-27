//
//  File.swift
//  
//
//  Created by Pedro Henrique on 09/03/24.
//

import Foundation
import CoreData

public protocol CoreDataHelperService {
    func saveObjectToCoreData<T>(object: T)
    func removeFavoritedNewsCoreData(id: UUID)
    func getFavoriteNewsDB()
    func removeFavoritedNews(index: Int)
    var dbCoreDataFavoriteNews: [NSManagedObject] { get }
}
