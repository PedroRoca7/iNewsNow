//
//  NewYorkTimesService.swift
//  INewsNow
//
//  Created by Pedro Henrique on 03/02/24.
//

import Foundation

protocol NewYorkTimesServiceDelegate: NSObject {
    func didFailMainNewsFetching()
    func didSuccedMainNewsFetching(mainNews: MainNewsModel)
    func didFailMostPopularFetching()
    func didSuccedMostPopularFetching(mostPopular: MostPopularNewsModel)
}

protocol NewYorkTimesServicing {
    var delegate: NewYorkTimesServiceDelegate? { get set }
    func loadMainNews()
    func loadMostPopularNews()
}

final class NewYorkTimesService {
    
    enum TypesApiNewYorkTimes {
        case urlMainNews(apiKey: String)
        case urlMostPopularNews(apiKey: String)
        
        var stringValue: String {
            switch self {
                
            case .urlMainNews(let apiKey):
                return "https://api.nytimes.com/svc/topstories/v2/home.json?api-key=\(apiKey)"
            case .urlMostPopularNews(let apiKey):
                return "https://api.nytimes.com/svc/mostpopular/v2/shared/1/facebook.json?api-key=\(apiKey)"
            }
        }
    }
    
    weak var delegate: NewYorkTimesServiceDelegate?
    private let apiKey = PrivateApiKeys.newsNewYorkTimeApiKey
    
}

extension NewYorkTimesService:  NewYorkTimesServicing {
    
    func loadMainNews() {
        guard let url = URL(string: TypesApiNewYorkTimes.urlMainNews(apiKey: apiKey).stringValue) else {
            self.delegate?.didFailMainNewsFetching()
            return }
        
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self,
                  let data = data,
                  error == nil else {
                self?.delegate?.didFailMainNewsFetching()
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let response = try decoder.decode(MainNewsModel.self, from: data)
                self.delegate?.didSuccedMainNewsFetching(mainNews: response)
            } catch {
                self.delegate?.didFailMainNewsFetching()
            }
        }
        dataTask.resume()
    }
    
    
    func loadMostPopularNews() {
        guard let url = URL(string: TypesApiNewYorkTimes.urlMostPopularNews(apiKey: apiKey).stringValue) else {
            self.delegate?.didFailMostPopularFetching()
            return }
        
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self,
                  let data = data,
                      error == nil else {
                self?.delegate?.didFailMostPopularFetching()
                return
            }
            do {
                let response = try JSONDecoder().decode(MostPopularNewsModel.self, from: data)
                self.delegate?.didSuccedMostPopularFetching(mostPopular: response)
            } catch {
                self.delegate?.didFailMostPopularFetching()
#if DEBUG
                print(error.localizedDescription)
#endif
            }
        }
        dataTask.resume()
    }
    
}
