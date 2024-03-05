//
//  NewsDataIOService.swift
//  INewsNow
//
//  Created by Pedro Henrique on 20/02/24.
//

import Foundation

final class NewsBrazilDataIOService {
    
    private let baseUrl = "https://newsdata.io/api/1/news?country=br&apikey=pub_38681ecae91e7da84f59d75ee44ef2f63a0cb"
    
    func loadNewsBrazil(onComplete: @escaping(NewsBrazilModel?, Error?)-> Void) {
        guard let url = URL(string: baseUrl) else { return }
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                onComplete(nil, error)
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let response = try decoder.decode(NewsBrazilModel.self, from: data)
                onComplete(response, nil)
            } catch {
                onComplete(nil, error)
            }
        }
        dataTask.resume()
    }
}
