//
//  NewsBrazilModel.swift
//  INewsNow
//
//  Created by Pedro Henrique on 20/02/24.
//

import Foundation

struct NewsBrazilModel: Codable {
    let results: [Article]
}

struct Article: Codable {
    var id: UUID
    var favorite: Bool = false
    var title: String = "Title Not Found"
    var description: String = "Description Not Found"
    var pubDate: String = ""
    var imageURL: String = "Image Not Found"
    var sourceId: String = "Author Not Found"
    
    enum CodingKeys: String, CodingKey {
        case title
        case description
        case pubDate
        case imageURL = "image_url"
        case sourceId = "source_id"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = UUID()
        imageURL = try container.decodeIfPresent(String.self, forKey: .imageURL) ?? imageURL
        pubDate = try container.decodeIfPresent(String.self, forKey: .pubDate) ?? pubDate
        title = try container.decodeIfPresent(String.self, forKey: .title) ?? title
        description = try container.decodeIfPresent(String.self, forKey: .description) ?? description
        sourceId = try container.decodeIfPresent(String.self, forKey: .sourceId) ?? sourceId
    }
}
