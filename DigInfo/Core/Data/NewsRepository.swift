//
//  File.swift
//  Diginfo
//
//  Created by Dhimas P Pangestu on 20/03/23.
//

import Foundation
import RxSwift

protocol NewsRepositoryProtocol {
    func getTopHeadlinessCountry() -> Observable<[TopHeadlineModel]>
    func getSavedNews() -> Observable<[TopHeadlineModel]>
    func addSavedNews(domain: TopHeadlineModel) -> Observable<Bool>
    func deleteSavedNews(domain: TopHeadlineModel) -> Observable<Bool>
}

final class NewsRepository: NSObject {
    typealias NewsInstance = (LocaleNewsSource, NewsRemoteSource) -> NewsRepository
    
    fileprivate let localeNews: LocaleNewsSource
    fileprivate let remoteNews: NewsRemoteSource
    
    private init (localeNews: LocaleNewsSource, remoteNews: NewsRemoteSource){
        self.localeNews = localeNews
        self.remoteNews = remoteNews
    }
    
    static let sharedInstance: NewsInstance = { localeRepo, remoteRepo  in
        return NewsRepository(localeNews: localeRepo, remoteNews: remoteRepo)
    }
}

extension NewsRepository: NewsRepositoryProtocol {
    func getTopHeadlinessCountry() -> Observable<[TopHeadlineModel]> {
        print("masuk get top headline repository")
        return self.localeNews.getNews()
            .map { NewsMapper.mapNewsEntitiesToDomain(input: $0) }
            .filter { !$0.isEmpty }
            .ifEmpty(switchTo: self.remoteNews.getTopHeadlineCountry()
            .map { NewsMapper.mapNewsResponseToEntities(input: $0) }
            .flatMap { self.localeNews.addNews(from: $0) }
            .filter { $0 }
            .flatMap { _ in self.localeNews.getNews()
                    .map { NewsMapper.mapNewsEntitiesToDomain(input: $0) }
            }
        )
    }
    func getSavedNews() -> Observable<[TopHeadlineModel]> {
        print("Get Entity Saved")
        return self.localeNews.getSavedNews()
            .map{ NewsMapper.mapSavedNewsEntitiesToDomain(input: $0) }
            .filter { !$0.isEmpty }
    }
    
    func addSavedNews(domain: TopHeadlineModel) -> Observable<Bool> {
        print("add save Entity")
        let newsToSaved = NewsMapper.newsDomainToSavedEntity(input: domain)
        return self.localeNews.addSaveNews(from: newsToSaved)
    }
    
    func deleteSavedNews(domain: TopHeadlineModel) -> Observable<Bool> {
        print("add save Entity")
        let newsToSaved = NewsMapper.newsDomainToSavedEntity(input: domain)
        return self.localeNews.deleteSavedNews(from: newsToSaved)
    }
}
