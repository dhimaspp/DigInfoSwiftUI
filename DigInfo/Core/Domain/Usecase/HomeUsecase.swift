//
//  HomeUsecase.swift
//  Diginfo
//
//  Created by Dhimas P Pangestu on 20/03/23.
//

import Foundation
import RxSwift

protocol HomeUsecase {
    func getTopHeadlineCountry() -> Observable<[TopHeadlineModel]>
    func getSavedNews() -> Observable<[TopHeadlineModel]>
    func addSaveNews(domain: TopHeadlineModel) -> Observable<Bool>
    func deleteSavedNews(domain: TopHeadlineModel) -> Observable<Bool>
}

class HomeInteractor: HomeUsecase {
    
    private let newsRepository: NewsRepositoryProtocol
    
    required init(repository: NewsRepositoryProtocol) {
        self.newsRepository = repository
    }
    
    func getTopHeadlineCountry() -> Observable<[TopHeadlineModel]> {
        return newsRepository.getTopHeadlinessCountry()
    }
    
    func getSavedNews() -> Observable<[TopHeadlineModel]> {
        return newsRepository.getSavedNews()
    }
    
    func addSaveNews(domain: TopHeadlineModel) -> Observable<Bool> {
        return newsRepository.addSavedNews(domain: domain)
    }
    
    func deleteSavedNews(domain: TopHeadlineModel) -> Observable<Bool> {
        return newsRepository.deleteSavedNews(domain: domain)
    }
}
