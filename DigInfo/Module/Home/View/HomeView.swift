//
//  HomeView.swift
//  DigInfo
//
//  Created by Dhimas P Pangestu on 08/04/23.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var presenter: HomePresenter
    
    var body: some View {
            ZStack{
                if presenter.loadingState {
                    VStack {
                      Text("Loading...")
                      ProgressView()
                    }
                } else {
                    ScrollView{
                        ForEach(
                            self.presenter.topHeadlineCountry,
                            id: \.title
                        ) { news in
                            ZStack{
                                self.presenter.linkBuilder(for: news){
                                    NewsWidget(presenter: presenter, news: news, isSaved: news.isSaved)
                                }.buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                }
            }.onAppear{
                        if self.presenter.topHeadlineCountry.isEmpty {
                            self.presenter.getTopHeadline()
                        }
            }.navigationBarTitle(Text("DigInfo"),
                                         displayMode: .automatic)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {

        ContentView(homePresenter: HomePresenter())
    }
}
