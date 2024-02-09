//
//  MainNewsModel.swift
//  INewsNow
//
//  Created by Pedro Henrique on 03/02/24.
//

import Foundation

struct MainNewsModel: Codable {
    let copyright: String
    var results: [NewsData]
}

struct NewsData: Codable {
    let title: String
    let abstract: String
    let url: String
    let byline: String
    let publishedDate: String
    var favorite: Bool = false
    let multimedia: [Multimedia]
    
    enum CodingKeys: String, CodingKey {
        case title
        case abstract
        case url
        case publishedDate = "published_date"
        case byline
        case multimedia
    }
}

struct Multimedia: Codable {
    let url: String
}
