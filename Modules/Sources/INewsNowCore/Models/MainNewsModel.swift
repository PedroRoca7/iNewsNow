//
//  MainNewsModel.swift
//  INewsNow
//
//  Created by Pedro Henrique on 03/02/24.
//

import Foundation

public struct MainNewsModel: Codable {
    public var results: [NewsData]
}

public struct NewsData: Codable {
    public var id: UUID
    public var favorite: Bool = false
    public var title: String = "Title not found"
    public var abstract: String = "Text not found"
    public var url: String = ""
    public var byline: String = "Author not found"
    public var publishedDate: String = ""
    public var multimedia: [Multimedia] = []
    
    enum CodingKeys: String, CodingKey {
        case title
        case abstract
        case url
        case publishedDate = "published_date"
        case byline
        case multimedia
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = UUID()
        title = try container.decodeIfPresent(String.self, forKey: .title) ?? title
        abstract = try container.decodeIfPresent(String.self, forKey: .abstract) ?? abstract
        url = try container.decodeIfPresent(String.self, forKey: .url) ?? url
        byline = try container.decodeIfPresent(String.self, forKey: .byline) ?? byline
        publishedDate = try container.decodeIfPresent(String.self, forKey: .publishedDate) ?? publishedDate
        multimedia = try container.decodeIfPresent([Multimedia].self, forKey: .multimedia) ?? multimedia
    }
}

public struct Multimedia: Codable {
    public var url: String = ""
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        url = try container.decodeIfPresent(String.self, forKey: .url) ?? url
    }
}
