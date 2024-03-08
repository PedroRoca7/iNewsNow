//
//  MostPopularNewsModel.swift
//  INewsNow
//
//  Created by Pedro Henrique on 03/02/24.
//

import Foundation

public struct MostPopularNewsModel: Codable {
    public var results: [PopularNewsData]
}

public struct PopularNewsData: Codable {
    public var id: UUID
    public var favorite: Bool = false
    public var url: String = ""
    public var publishedDate: String = ""
    public var title: String = "Title not found"
    public var abstract: String = "Text not found"
    public var byline: String = "Author not found"
    public var media: [Media] = []
    
    enum CodingKeys: String, CodingKey {
        case url
        case byline
        case title
        case abstract
        case publishedDate = "published_date"
        case media
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = UUID()
        url = try container.decodeIfPresent(String.self, forKey: .url) ?? url
        publishedDate = try container.decodeIfPresent(String.self, forKey: .publishedDate) ?? publishedDate
        title = try container.decodeIfPresent(String.self, forKey: .title) ?? title
        abstract = try container.decodeIfPresent(String.self, forKey: .abstract) ?? abstract
        byline = try container.decodeIfPresent(String.self, forKey: .byline) ?? byline
        media = try container.decodeIfPresent([Media].self, forKey: .media) ?? media
    }
}

public struct Media: Codable {
    public var mediaMetadata: [MediaMetadatum] = []
    
    enum CodingKeys: String, CodingKey {
        case mediaMetadata = "media-metadata"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        mediaMetadata = try container.decodeIfPresent([MediaMetadatum].self, forKey: .mediaMetadata) ?? mediaMetadata
    }
    
}

public struct MediaMetadatum: Codable {
    public var url: String = ""
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        url = try container.decodeIfPresent(String.self, forKey: .url) ?? url
    }
}
