//
//  DetailView.swift
//  DigInfo
//
//  Created by Dhimas P Pangestu on 08/04/23.
//

import SwiftUI

import SwiftUI
import CachedAsyncImage

struct DetailView: View {
  @ObservedObject var presenter: DetailPresenter

  var body: some View {
    ZStack {
      if presenter.loadingState {
        loadingIndicator
      } else {
        ScrollView(.vertical) {
          VStack {
            imageCategory
            spacer
            content
            spacer
          }.padding()
        }
      }
    }.navigationBarTitle(Text(self.presenter.newsDetail.title), displayMode: .automatic)
  }
}

extension DetailView {
  var spacer: some View {
    Spacer()
  }

  var loadingIndicator: some View {
    VStack {
      Text("Loading...")
      ProgressView()
    }
  }

  var imageCategory: some View {
    CachedAsyncImage(url: URL(string: self.presenter.newsDetail.urlToImage)) { image in
      image.resizable()
    } placeholder: {
      ProgressView()
    }.scaledToFill().frame(alignment: .center)
  }

  var description: some View {
      Text(self.presenter.newsDetail.content)
      .font(.system(size: 15))
  }

  func headerTitle(_ title: String) -> some View {
    return Text(title)
      .font(.custom("Hoefler Text", size: 24))
      .lineLimit(3)
  }

  var content: some View {
    VStack(alignment: .leading, spacing: 0) {
      headerTitle("Description")
        .padding([.top, .bottom])
      description
    }
  }
}
