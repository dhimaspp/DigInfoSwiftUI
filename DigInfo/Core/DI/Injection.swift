//
//  Injection.swift
//  Diginfo
//
//  Created by Dhimas P Pangestu on 20/03/23.
//

import Factory
import Foundation
import RealmSwift

extension Container{
    
    var provideRepository: Factory<NewsRepositoryProtocol> {
        let realm = try? Realm()

        let remote: NewsRemoteSource = NewsRemoteSource.sharedInstance
        let locale: LocaleNewsSource = LocaleNewsSource.sharedInstance(realm)
        
        return self { NewsRepository.sharedInstance(locale, remote) }
    }
    
    var provideHome: Factory<HomeUsecase> {
        self { HomeInteractor(repository: self.provideRepository.resolve()) }
    }
    
    var provideDetail: Factory<DetailUseCase> {
        self { DetailInteractor(repository: self.provideRepository.resolve()) }
    }
}
