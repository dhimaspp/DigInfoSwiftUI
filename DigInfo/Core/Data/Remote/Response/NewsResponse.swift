//
//  NewsResponse.swift
//  Diginfo
//
//  Created by Dhimas P Pangestu on 20/03/23.
//

import Foundation

struct NewsResponse: Decodable {
    let status: String
    let totalResults: Int
    let articles: [Article]
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case totalResults = "totalResults"
        case articles = "articles"
    }
}

struct Article: Decodable {
    let source: Source
    let author: String?
    let title: String?
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
    
    enum CodingKeys: String, CodingKey {
        case source = "source"
        case author = "author"
        case title = "title"
        case description = "description"
        case url = "url"
        case urlToImage = "urlToImage"
        case publishedAt = "publishedAt"
        case content = "content"
    }
}

struct Source: Decodable {
    let id: String?
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
}
