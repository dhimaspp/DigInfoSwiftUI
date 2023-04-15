//
//  TopHeadlineModel.swift
//  Diginfo
//
//  Created by Dhimas P Pangestu on 20/03/23.
//

import Foundation
import RealmSwift

struct TopHeadlineModel: Equatable, Identifiable {

    let id: String
    let name: String
    let title: String
    let author: String
    let description: String
    let detailUrl: String
    let urlToImage: String
    let content: String
    let publishedAt: String
    var isSaved: Bool

}
