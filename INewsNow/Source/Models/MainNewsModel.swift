//
//  MainNewsModel.swift
//  INewsNow
//
//  Created by Pedro Henrique on 03/02/24.
//

import Foundation

protocol NewsProtocol: Any {
    var title: String? { get set }
    var abstract: String? { get set }
    var publishedDate: String? { get set }
    var byline: String? { get set }
    var favorite: Bool { get set }
    var multimedia: [Multimedia] { get set }
    var media: [Media] { get set }
    var id: UUID { get }
}

extension NewsProtocol {
    var media: [Media] {
        get { return [] } set{}
    }
    var multimedia: [Multimedia] {
        get { return [] } set{}
    }
}


struct MainNewsModel: Codable {
    var results: [NewsData]
}

struct NewsData: Codable {
    var id: UUID
    var favorite: Bool = false
    var title: String? = "Title not found"
    var abstract: String? = "Text not found"
    var url: String? = ""
    var byline: String? = "Author not found"
    var publishedDate: String? = "Date not found"
    var multimedia: [Multimedia]? = []
    
    enum CodingKeys: String, CodingKey {
        case title
        case abstract
        case url
        case publishedDate = "published_date"
        case byline
        case multimedia
    }
    
    init(from decoder: Decoder) throws {
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

struct Multimedia: Codable {
    var url: String? = ""
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        url = try container.decodeIfPresent(String.self, forKey: .url) ?? url
    }
}
