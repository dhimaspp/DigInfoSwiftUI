//
//  Network.swift
//  Diginfo
//
//  Created by Dhimas P Pangestu on 20/03/23.
//

import Foundation

struct API {
    static let baseUrl = "https://newsapi.org/v2/"
    static let apiToken = "4cacb92f67d24ef0b02f956d7b764bbe"
    static let countryID = "us"
}

protocol Endpoint {
    
    var url: String { get }
    
}

enum Endpoints{
    
    enum Gets: Endpoint {
        case topHeadlineCountry
        case topHeadlineCategories
        
        public var url: String {
            switch self {
            case.topHeadlineCountry: return "\(API.baseUrl)top-headlines?country=us&apikey=\(API.apiToken)"
            case.topHeadlineCategories: return "\(API.baseUrl)"
            }
        }
    }
}

struct TopHeadlineParameter: Encodable {
    let country: String
    let language: String
    let category: String
    let token: String
}
