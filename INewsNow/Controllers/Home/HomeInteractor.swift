//
//  HomeInteractor.swift
//  INewsNow
//
//  Created by Pedro Henrique on 10/04/24.
//

import Foundation

protocol HomeInteracting {
    func getNewsFromBrazil()
    func saveObjectInDB(myObjectAtIndex index: Int)
}

final class HomeInteractor: NSObject, HomeInteracting {
    
    private var service: NewsBrazilDataIOServicing
    private var presenter: HomePresenting
    
    init(service: NewsBrazilDataIOServicing, presenter: HomePresenting) {
        self.service = service
        self.presenter = presenter
    }
    
    func getNewsFromBrazil() {
        service.loadNewsBrazil()
    }
    
    func saveObjectInDB(myObjectAtIndex index: Int) {
        guard let objectToSave = presenter.getObjectAtIndex(index) else {
            return
        }
        appendOrRemoveFavoritesNewsArray(newsData: objectToSave)
    }
    
    private func appendOrRemoveFavoritesNewsArray(newsData: Article) {
        if newsData.favorite {
            CoreDataHelper.shared.saveObjectToCoreData(object: newsData)
        } else {
            CoreDataHelper.shared.removeFavoritedNewsCoreData(id: newsData.id)
        }
    }
}

extension HomeInteractor: NewsBrazilDataIOServiceDelegate {
    func didFailNewsBrazilFetching() {
        presenter.didFailNewsBrazilFetching()
    }
    
    func didSuccedNewsBrazilFetching(newsBrazil: NewsBrazilModel) {
        presenter.receiveNewsFromBrazil(newsBrazil: newsBrazil)
    }
}
