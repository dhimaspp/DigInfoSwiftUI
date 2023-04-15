//
//  HomeRouter.swift
//  Diginfo
//
//  Created by Dhimas P Pangestu on 21/03/23.
//

import SwiftUI

public class HomeRouter {
    
    func makeDetailView(for newsDetail: TopHeadlineModel) -> some View {
      return DetailView(presenter: DetailPresenter(newsDetil: newsDetail))
    }
}
