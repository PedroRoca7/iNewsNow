//
//  NewYorkTimesService.swift
//  INewsNow
//
//  Created by Pedro Henrique on 03/02/24.
//

import Foundation

protocol NewYorkTimesServicing {
    func loadMainNews(onComplete: @escaping(MainNewsModel?, Error?) -> Void)
    func loadMostPopularNews(onComplete: @escaping(MostPopularNewsModel?, Error?) -> Void)
}

final class NewYorkTimesService: NewYorkTimesServicing {
    
    enum TypesApiNewYorkTimes: String {
        case urlMainNews = "https://api.nytimes.com/svc/topstories/v2/home.json?api-key=N8U4kVw1Icdw3YiGFhThZqIGTAF9PJ7l"
        case urlMostPopularNews = "https://api.nytimes.com/svc/mostpopular/v2/shared/1/facebook.json?api-key=N8U4kVw1Icdw3YiGFhThZqIGTAF9PJ7l"
    }
    
    static let serviceGetNews = NewYorkTimesService()
    
    func loadMainNews(onComplete: @escaping(MainNewsModel?, Error?) -> Void) {
        guard let url = URL(string: TypesApiNewYorkTimes.urlMainNews.rawValue) else { return }
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                onComplete(nil, error)
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let response = try decoder.decode(MainNewsModel.self, from: data)
                onComplete(response, nil)
            } catch {
                onComplete(nil, error)
            }
        }
        dataTask.resume()
    }
    
    func loadMostPopularNews(onComplete: @escaping(MostPopularNewsModel?, Error?) -> Void) {
        guard let url = URL(string: TypesApiNewYorkTimes.urlMostPopularNews.rawValue) else { return }
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                onComplete(nil, error)
                return
            }
            do {
                let dataMainNews = try JSONDecoder().decode(MostPopularNewsModel.self, from: data)
                onComplete(dataMainNews, nil)
            } catch {
                onComplete(nil, error)
#if DEBUG
                print(error.localizedDescription)
#endif
            }
        }
        dataTask.resume()
    }
}
