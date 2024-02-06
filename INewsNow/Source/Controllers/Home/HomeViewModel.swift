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
    
    private let service = NewYorkTimesService()
    private(set) var mainNewsList: MainNewsModel?
    weak var delegate: HomeViewModelDelegate?
    
    func loadMainNews() {
        self.service.loadMainNews { data, error in
            if let error = error {
                self.delegate?.failure()
                print(error.localizedDescription)
            } else if let data = data {
                self.mainNewsList = data
                self.delegate?.success()
            }
        }
    }
}
