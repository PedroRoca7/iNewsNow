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
    let title: String
    let description: String
    let pubDate: String
    let imageUrl: String
    let sourceId: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case description
        case pubDate
        case imageUrl = "image_url"
        case sourceId = "source_id"
    }
}
