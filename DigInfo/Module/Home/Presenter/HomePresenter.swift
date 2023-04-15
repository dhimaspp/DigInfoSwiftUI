//
//  HomePresenter.swift
//  Diginfo
//
//  Created by Dhimas P Pangestu on 21/03/23.
//

import Foundation
import RxSwift
import SwiftUI
import Factory

class HomePresenter: ObservableObject {
    
    private let homeUseCase = Container.shared.provideHome()
    private let router = HomeRouter()
    private let disposeBag = DisposeBag()
    
    @Published var topHeadlineCountry: [TopHeadlineModel] = []
    @Published var savedNews: [TopHeadlineModel] = []
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    
    func getTopHeadline(){
        print("masuk get headline home presenter")
        loadingState = true
        homeUseCase.getTopHeadlineCountry()
            .observe(on: MainScheduler.instance)
            .subscribe{ result in
                self.topHeadlineCountry = result
                print("sekses get headline home presenter " + result[0].name)
                self.getSavedNews()
            } onError: { error in
                self.errorMessage = error.localizedDescription
                print("error get headline home presenter " + error.localizedDescription)
            } onCompleted: {
                print("loading get headline home presenter kelar")
                self.loadingState = false
            }.disposed(by: disposeBag)
    }
    
    func getSavedNews(){
        homeUseCase.getSavedNews()
            .observe(on: MainScheduler.instance)
            .subscribe{ result in
                for savedArticle in result {
                    let isArticleInCountryList = self.topHeadlineCountry.contains { $0.title == savedArticle.title && $0.publishedAt == savedArticle.publishedAt }
                    if isArticleInCountryList {
                        
                        if let index = self.topHeadlineCountry.firstIndex(where: { $0.title == savedArticle.title }) {
                                  
                            self.topHeadlineCountry[index].isSaved = true
                            print("topHeadlineCountry save news home presenter modified")
                                }
                    } else {
                        // The article does not exist in topHeadlineCountry
                        // Do something else here, e.g. add the article to topHeadlineCountry
                    }
                }
            } onError: { error in
                self.errorMessage = error.localizedDescription
                print("error save news home presenter " + error.localizedDescription)
            } onCompleted: {
                print("loading get headline home presenter save news kelar")
            }.disposed(by: disposeBag)
    }
    
    func addSaveNews(domain: TopHeadlineModel){
        homeUseCase.addSaveNews(domain: domain)
            .observe(on: MainScheduler.instance)
            .subscribe{ result in
                
                    
                if let index = self.topHeadlineCountry.firstIndex(where: { $0.title == domain.title }) {
                    
                    self.topHeadlineCountry[index].isSaved = true
                    print("topHeadlineCountry add save news home presenter modified")
                }
                
                print("subscribe add save news home presenter kelar " + String(result))
            } onError: { error in
                self.errorMessage = error.localizedDescription
                print("error add save news home presenter " + error.localizedDescription)
            } onCompleted: {
                print("loading get headline home presenter save kelar")
            }.disposed(by: disposeBag)
    }
    
    func deleteSavedNews(domain: TopHeadlineModel){
        homeUseCase.deleteSavedNews(domain: domain)
            .observe(on: MainScheduler.instance)
            .subscribe{ result in
                
                    
                if let index = self.topHeadlineCountry.firstIndex(where: { $0.title == domain.title }) {
                    
                    self.topHeadlineCountry[index].isSaved = false
                    print("topHeadlineCountry delete save news home presenter modified")
                }
                
                print("subscribe delete save news home presenter kelar " + String(result))
            } onError: { error in
                self.errorMessage = error.localizedDescription
                print("error delete save news home presenter " + error.localizedDescription)
            } onCompleted: {
                print("loading delete headline home presenter kelar")
            }.disposed(by: disposeBag)
    }
    
    func linkBuilder<Content: View>(
      for newsDetail: TopHeadlineModel,
      @ViewBuilder content: () -> Content
    ) -> some View {
      NavigationLink(
      destination: router.makeDetailView(for: newsDetail)) { content() }
    }
}
