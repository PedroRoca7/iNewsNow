//
//  MostPopularNewsModel.swift
//  INewsNow
//
//  Created by Pedro Henrique on 03/02/24.
//

import Foundation

struct MostPopularNewsModel: Codable {
    var results: [PopularNewsData]
}

struct PopularNewsData: Codable {
    var favorite: Bool = false
    var url: String? = ""
    var publishedDate: String? = "Date not found"
    var title: String? = "Title not found"
    var abstract: String? = "Text not found"
    var byline: String? = "Author not found"
    var media: [Media]? = []
    
    enum CodingKeys: String, CodingKey {
        case url
        case byline
        case title
        case abstract
        case publishedDate = "published_date"
        case media
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        url = try container.decodeIfPresent(String.self, forKey: .url) ?? url
        publishedDate = try container.decodeIfPresent(String.self, forKey: .publishedDate) ?? publishedDate
        title = try container.decodeIfPresent(String.self, forKey: .title) ?? title
        abstract = try container.decodeIfPresent(String.self, forKey: .abstract) ?? abstract
        byline = try container.decodeIfPresent(String.self, forKey: .byline) ?? byline
        media = try container.decodeIfPresent([Media].self, forKey: .media) ?? media
    }
}

struct Media: Codable {
    var mediaMetadata: [MediaMetadatum]? = []
    
    enum CodingKeys: String, CodingKey {
        case mediaMetadata = "media-metadata"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        mediaMetadata = try container.decodeIfPresent([MediaMetadatum].self, forKey: .mediaMetadata) ?? mediaMetadata
    }
    
}

struct MediaMetadatum: Codable {
    var url: String? = ""
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        url = try container.decodeIfPresent(String.self, forKey: .url) ?? url
    }
}
