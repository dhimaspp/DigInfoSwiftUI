//
//  DetailNewsRouter.swift
//  Diginfo
//
//  Created by Dhimas P Pangestu on 06/04/23.
//

import SwiftUI
import Factory

public class DetailPresenter: ObservableObject {
    
    private let detailUseCase = Container.shared.provideDetail()

    @Published var newsDetail: TopHeadlineModel
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false

    init(newsDetil: TopHeadlineModel) {
        newsDetail = newsDetil
    }
}
