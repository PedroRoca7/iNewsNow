//
//  NewYorkTimesService.swift
//  INewsNow
//
//  Created by Pedro Henrique on 03/02/24.
//

import Foundation

public protocol NewYorkTimesServicing {
    func loadMainNews<T: Decodable>() async throws -> T
    func loadMostPopularNews<T: Decodable>(onComplete: @escaping(T?, Error?) -> Void)
}

public enum APIError: Error {
    case requestFailed
    case invalidData
}

public final class NewYorkTimesService: NewYorkTimesServicing {
    
    enum TypesApiNewYorkTimes: String {
        case urlMainNews = "https://api.nytimes.com/svc/topstories/v2/home.json?api-key=N8U4kVw1Icdw3YiGFhThZqIGTAF9PJ7l"
        case urlMostPopularNews = "https://api.nytimes.com/svc/mostpopular/v2/shared/1/facebook.json?api-key=N8U4kVw1Icdw3YiGFhThZqIGTAF9PJ7l"
    }
        
    public init(){}
    
    public func loadMainNews<T: Decodable>() async throws -> T {
        guard let url = URL(string: TypesApiNewYorkTimes.urlMainNews.rawValue) else {
            throw APIError.requestFailed }
        
        return try await withCheckedThrowingContinuation { continuation in
            let dataTask1 = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data1 = data, error == nil else {
                    guard let error1 = error else {
                        fatalError("Expected non-nil result 'error1' in the non-error case")
                    }
                    continuation.resume(throwing: error1)
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let response = try decoder.decode(T.self, from: data1)
                    continuation.resume(returning: response)
                } catch {
                    continuation.resume(throwing: error)
                }
            }
            dataTask1.resume()
        }
    }
    
    public func loadMostPopularNews<T: Decodable>(onComplete: @escaping(T?, Error?) -> Void) {
        guard let url = URL(string: TypesApiNewYorkTimes.urlMostPopularNews.rawValue) else { return }
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                onComplete(nil, error)
                return
            }
            do {
                let dataMainNews = try JSONDecoder().decode(T.self, from: data)
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
