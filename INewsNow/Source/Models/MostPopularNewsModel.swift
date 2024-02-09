//
//  MostPopularNewsModel.swift
//  INewsNow
//
//  Created by Pedro Henrique on 03/02/24.
//

import Foundation

struct MostPopularNewsModel: Codable {
    let copyright: String
    var results: [PopularNewsData]
}

struct PopularNewsData: Codable {
    let url: String
    let publishedDate: String
    let byline, title, abstract: String
    var favorite: Bool = false
    let media:[Media]
    enum CodingKeys: String, CodingKey {
        case url, byline,title, abstract
        case publishedDate = "published_date"
        case media
    }
}

struct Media: Codable {
    let mediaMetadata: [MediaMetadatum]
    
    enum CodingKeys: String, CodingKey {
        case mediaMetadata = "media-metadata"
    }
}

struct MediaMetadatum: Codable {
    let url: String
}
