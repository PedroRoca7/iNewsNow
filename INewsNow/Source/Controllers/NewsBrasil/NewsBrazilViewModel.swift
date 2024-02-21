//
//  NewsBrazilViewModel.swift
//  INewsNow
//
//  Created by Pedro Henrique on 20/02/24.
//

import Foundation

protocol NewsBrazilViewModelDelegate: AnyObject {
    func success()
    func failure()
}

protocol NewsBrazilViewModeling {
    func loadNewsBrazil()
    func showScreenNewsWorld()
    var delegate: NewsBrazilViewModelDelegate? { get set }
    var newsBrazilList: NewsBrazilModel? { get }
}

final class NewsBrazilViewModel: NewsBrazilViewModeling {
    
    private var service: NewsBrazilDataIOService
    private var coordinator: NewsBrazilCoordinating
    private(set) var newsBrazilList: NewsBrazilModel?
    weak var delegate: NewsBrazilViewModelDelegate?
    
    init(service: NewsBrazilDataIOService, coordinator: NewsBrazilCoordinating) {
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
