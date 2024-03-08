//
//  NewsBrazilModel.swift
//  INewsNow
//
//  Created by Pedro Henrique on 20/02/24.
//

import Foundation

public struct NewsBrazilModel: Codable {
    public var results: [Article]
}

public struct Article: Codable {
    public var id: UUID
    public var favorite: Bool = false
    public var title: String = "Title Not Found"
    public var description: String = "Description Not Found"
    public var pubDate: String = ""
    public var imageURL: String = "Image Not Found"
    public var sourceId: String = "Author Not Found"
    
    enum CodingKeys: String, CodingKey {
        case title
        case description
        case pubDate
        case imageURL = "image_url"
        case sourceId = "source_id"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = UUID()
        imageURL = try container.decodeIfPresent(String.self, forKey: .imageURL) ?? imageURL
        pubDate = try container.decodeIfPresent(String.self, forKey: .pubDate) ?? pubDate
        title = try container.decodeIfPresent(String.self, forKey: .title) ?? title
        description = try container.decodeIfPresent(String.self, forKey: .description) ?? description
        sourceId = try container.decodeIfPresent(String.self, forKey: .sourceId) ?? sourceId
    }
}
