//
//  NewsDataIOService.swift
//  INewsNow
//
//  Created by Pedro Henrique on 20/02/24.
//

import Foundation

protocol NewsBrazilDataIOServiceDelegate: NSObject {
    func didFailNewsBrazilFetching()
    func didSuccedNewsBrazilFetching(newsBrazil: NewsBrazilModel)
}

protocol NewsBrazilDataIOServicing {
    var delegate: NewsBrazilDataIOServiceDelegate? { get set }
    func loadNewsBrazil()
    func loadCategoryNewsBrazil(category: String)
}

final class NewsBrazilDataIOService {
    
    private let baseURL = "https://newsdata.io/api/1/news?country=br"
    private let apiKey = PrivateApiKeys.newsBrazilApiKey
    
    weak var delegate: NewsBrazilDataIOServiceDelegate?
    
}

extension NewsBrazilDataIOService: NewsBrazilDataIOServicing {
    
    func loadNewsBrazil() {
        let urlString = "\(baseURL)&apikey=\(apiKey)"
        guard let url = URL(string: urlString) else { return }
        
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self,
                  let data = data,
                  error == nil else {
                self?.delegate?.didFailNewsBrazilFetching()
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let response = try decoder.decode(NewsBrazilModel.self, from: data)
                self.delegate?.didSuccedNewsBrazilFetching(newsBrazil: response)
            } catch {
                self.delegate?.didFailNewsBrazilFetching()
            }
        }
        dataTask.resume()
    }
    
    func loadCategoryNewsBrazil(category: String) {
        let categoryName = category.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "\(baseURL)&category=\(categoryName)&apikey=\(apiKey)"
        
        guard let url = URL(string: urlString) else { return }
        
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self,
                  let data = data,
                  error == nil else {
                self?.delegate?.didFailNewsBrazilFetching()
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let response = try decoder.decode(NewsBrazilModel.self, from: data)
                self.delegate?.didSuccedNewsBrazilFetching(newsBrazil: response)
            } catch {
                self.delegate?.didFailNewsBrazilFetching()
            }
        }
        dataTask.resume()
    }
}
