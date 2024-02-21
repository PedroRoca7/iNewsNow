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
    
    func showScreenNewsWorld() {
        coordinator.showNewsWorld()
    }
}
