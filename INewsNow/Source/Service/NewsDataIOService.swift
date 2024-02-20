//
//  NewsDataIOService.swift
//  INewsNow
//
//  Created by Pedro Henrique on 20/02/24.
//

import Foundation

enum CategoryNewsBrazil: String {
    case sports = "sports"
    case technology = "technology"
    case business = "business"
    case science = "science"
    case entertainment = "entertainment"
    case health = "health"
    case world = "world"
    case politics = "politics"
    case environment = "environment"
    case food = "food"
}

final class NewsBrazilDataIOService {
    
    let baseUrl = ""
    
    func loadNewsBrazil(onComplete: @escaping(NewsBrazilModel?, Error?)-> Void) {
        guard let url = URL(string: baseUrl) else { return }
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                onComplete(nil, error)
                return
            }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(NewsBrazilModel.self, from: data)
                onComplete(response, nil)
            } catch {
                onComplete(nil, error)
            }
        }
        dataTask.resume()
    }
}
