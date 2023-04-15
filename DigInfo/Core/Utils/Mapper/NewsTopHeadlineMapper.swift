//
//  NewsTopHeadlineMapper.swift
//  Diginfo
//
//  Created by Dhimas P Pangestu on 20/03/23.
//

import Foundation

final class NewsMapper {

  static func mapNewsResponsesToDomains(
    input newsArticlesResponse: [Article]
  ) -> [TopHeadlineModel] {
      return newsArticlesResponse.map { result in
          return TopHeadlineModel(id: result.source.id ?? "", name: result.source.name , title: result.title ?? "" , author: result.author ?? "Unknown", description: result.description ?? "", detailUrl: result.url, urlToImage: result.urlToImage ?? "https://via.placeholder.com/600x600/cccccc/575757?text=sorry+no+image+here", content: result.content ?? "", publishedAt: result.publishedAt ?? "", isSaved: false)
      }
  }
    
    static func mapNewsResponseToEntities(
        input newsArticlesResponse: [Article]
    ) -> [ArticleEntity] {
        return newsArticlesResponse.map{ result in
            let newNewsArticle = ArticleEntity()
            newNewsArticle.id = result.source.id ?? ""
            newNewsArticle.name = result.source.name
            newNewsArticle.author = result.author ?? "unknown"
            newNewsArticle.title = result.title ?? ""
            newNewsArticle.desc = result.description ?? "There is no description here"
            newNewsArticle.url = result.url
            newNewsArticle.urlToImage = result.urlToImage ?? "https://via.placeholder.com/600x600/cccccc/575757?text=sorry+no+image+here"
            newNewsArticle.content = result.content ?? "There is no content here"
            newNewsArticle.publishedAt = result.publishedAt ?? "2023-04-05T14:15:00Z"
            return newNewsArticle
        }
    }

    static func mapNewsEntitiesToDomain(
        input newsArticleEntity: [ArticleEntity]
    ) -> [TopHeadlineModel] {
        return newsArticleEntity.map { result in
            return TopHeadlineModel(
                id: result.id, name: result.name, title: result.title, author: result.author, description: result.desc, detailUrl: result.url, urlToImage: result.urlToImage, content: result.content, publishedAt: result.publishedAt, isSaved: false
            )
        }
    }
    
    static func mapSavedNewsEntitiesToDomain(
        input newsArticleEntity: [SavedNewsEntity]
    ) -> [TopHeadlineModel] {
        return newsArticleEntity.map{ result in
            return TopHeadlineModel(
                id: result.id, name: result.name, title: result.title, author: result.author, description: result.desc, detailUrl: result.url, urlToImage: result.urlToImage, content: result.content, publishedAt: result.publishedAt, isSaved: false
            )
        }
    }
    
    static func mapNewsNewsEntitiesToSavedEntities(
        input newsArticleDomain: [ArticleEntity]
    ) -> [SavedNewsEntity] {
        return newsArticleDomain.map { result in
            let newNewsArticle = SavedNewsEntity()
            newNewsArticle.id = result.id
            newNewsArticle.name = result.name
            newNewsArticle.author = result.author
            newNewsArticle.title = result.title
            newNewsArticle.desc = result.description
            newNewsArticle.url = result.url
            newNewsArticle.urlToImage = result.urlToImage
            newNewsArticle.content = result.content
            newNewsArticle.publishedAt = result.publishedAt
            return newNewsArticle
        }
    }
    
    static func newsDomainToSavedEntity(
        input newsArticleDomain: TopHeadlineModel
    ) -> SavedNewsEntity {
            let newNewsArticle = SavedNewsEntity()
            newNewsArticle.id = newsArticleDomain.id
            newNewsArticle.name = newsArticleDomain.name
            newNewsArticle.author = newsArticleDomain.author
            newNewsArticle.title = newsArticleDomain.title
            newNewsArticle.desc = newsArticleDomain.description
            newNewsArticle.url = newsArticleDomain.detailUrl
            newNewsArticle.urlToImage = newsArticleDomain.urlToImage
            newNewsArticle.content = newsArticleDomain.content
            newNewsArticle.publishedAt = newsArticleDomain.publishedAt
            return newNewsArticle
        
    }
}
