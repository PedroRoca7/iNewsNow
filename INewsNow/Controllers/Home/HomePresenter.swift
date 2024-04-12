//
//  HomePresenter.swift
//  INewsNow
//
//  Created by Pedro Henrique on 10/04/24.
//

import Foundation

protocol HomePresenting {
    func getObjectAtIndex(_ index: Int) -> Article?
    func didFailNewsBrazilFetching()
    func receiveNewsFromBrazil(newsBrazil: NewsBrazilModel)
    var newsBrazilList: NewsBrazilModel? { get set }
    var controller: HomeViewControlling? { get set }
}

final class HomePresenter: HomePresenting {
    
    var newsBrazilList: NewsBrazilModel?
    weak var controller: HomeViewControlling?
    
    func receiveNewsFromBrazil(newsBrazil: NewsBrazilModel) {
        self.newsBrazilList = newsBrazil
        controller?.didFinishLoading()
        controller?.reloadData(newsBrazil: newsBrazil)
    }
    
    func getObjectAtIndex(_ index: Int) -> Article? {
        setFavoriteNews(index)
        return newsBrazilList?.results[index]
    }
    
    func didFailNewsBrazilFetching() {
        controller?.didFailNewsFetching()
    }
    
    private func setFavoriteNews(_ index: Int) {
        guard let hasFavoritedNewsBrazil = newsBrazilList?.results[index].favorite else { return }
        newsBrazilList?.results[index].favorite = !hasFavoritedNewsBrazil
    }
    
}
