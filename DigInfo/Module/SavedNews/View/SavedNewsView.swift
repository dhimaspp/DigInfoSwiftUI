//
//  SavedNewsView.swift
//  DigInfo
//
//  Created by Dhimas P Pangestu on 09/04/23.
//

import SwiftUI

struct SavedNewsView: View {
    @ObservedObject var presenter: HomePresenter
    
    var body: some View {
            ZStack{
                if presenter.loadingState {
                    VStack {
                      Text("Loading...")
                      ProgressView()
                    }
                } else if presenter.topHeadlineCountry.filter { $0.isSaved }.isEmpty {
                    VStack {
                        Image(systemName: "bookmark")
                        .font(.system(size: 50))
                        .foregroundColor(.gray)
                        Text("There is no saved news").font(.custom("Hoefler Text", size: 26))
                    }
                } else {
                    ScrollView{
                        ForEach(
                            self.presenter.topHeadlineCountry,
                            id: \.title
                        ) { news in
                            ZStack{
                                self.presenter.linkBuilder(for: news){
                                    if news.isSaved == true{
                                        SavedNewsWidget(presenter: presenter, news: news, isSaved: true)
                                    }
                                }.buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                }
            }.onAppear{
                        
                            self.presenter.getSavedNews()
                        
            }.navigationBarTitle(Text("Saved News"),
                                         displayMode: .automatic)
    }
}

//struct SavedNewsView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        let savedNewsPresenter = SavedNewsPresenter(savedNewsUseCase: Injection.init().provideSavedNews())
//
//        ContentView().environmentObject(savedNewsPresenter)
//    }
//}
