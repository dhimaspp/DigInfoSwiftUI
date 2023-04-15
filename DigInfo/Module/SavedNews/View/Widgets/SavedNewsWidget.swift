//
//  NewsWidget.swift
//  DigInfo
//
//  Created by Dhimas P Pangestu on 08/04/23.
//

import SwiftUI
import CachedAsyncImage

struct SavedNewsWidget: View {
    @ObservedObject var presenter: HomePresenter
    var news: TopHeadlineModel
    @State var isSaved: Bool
    
    var body: some View {
        VStack{
            HStack{
                imageCategory
                content
            }.frame(width: UIScreen.main.bounds.width - 32 , height: 140, alignment: .topLeading).padding(EdgeInsets(
                top: 0, leading: 0, bottom: 0, trailing: 20
            ))
            descNews
        }.frame(width: UIScreen.main.bounds.width, height: 200, alignment: .top).padding(EdgeInsets(
            top: 0, leading: 30, bottom: 10, trailing: 20
        ))
    }
}

extension SavedNewsWidget {

    var imageCategory: some View {
        CachedAsyncImage(url: URL(string: news.urlToImage)) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
        }.cornerRadius(10).frame(width: 120, height: 120, alignment: .center).padding(.top, 20)
    }

    var content: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack{
                Text(news.author)
                    .font(.custom("Hiragino Mincho ProN", size: 14)).fontWeight(Font.Weight.semibold).foregroundColor(.gray)
                Spacer()
                Button(action: {
                    if isSaved{
                        presenter.deleteSavedNews(domain: news)
                        isSaved = false
                    } else {
                        presenter.addSaveNews(domain: news)
                        isSaved = true
                    }
                }) {
                    Image(systemName: isSaved ? "bookmark.fill": "bookmark")
                        .foregroundColor(news.isSaved ? Color.black : Color.black)
                }.frame(alignment: .trailing)
            }.frame(width: UIScreen.main.bounds.width - 160,alignment: .leading)
            Text(news.title)
                .font(.custom("Hoefler Text", size: 24))
                .multilineTextAlignment(.leading)
                .lineLimit(3).frame(width: UIScreen.main.bounds.width - 140, height: 80,alignment: .topLeading).padding(.leading, 0)
                
        }.frame(alignment: .top).padding(
            EdgeInsets(
                top: 0,
                leading: 0,
                bottom: 12,
                trailing: 12
            )
        )
        .frame(width: UIScreen.main.bounds.width, height: 120, alignment: .topLeading).padding(.top, 20)
        .background(Color.white)
    }
    
    var descNews: some View {
        VStack{
            HStack{
                Text(news.name + " -").font(.custom("Hoefler Text", size: 14)).bold()
                
                DateTimeView(dateTimeString: news.publishedAt)
            }.frame(width: UIScreen.main.bounds.width, height: 10, alignment: .leading).padding(EdgeInsets(
                top: 10,
                leading: 20,
                bottom: 0,
                trailing: 0
            ))
            Text(news.description).font(.custom("Hoefler Text", size: 14)).lineLimit(2)
                .foregroundColor(.gray).truncationMode(Text.TruncationMode.tail)
                .frame(width: UIScreen.main.bounds.width - 18, height: 40, alignment: .leading).lineSpacing(3)
        }
    }
    
    
}

struct SavedNewsWidget_Previews: PreviewProvider {

  static var previews: some View {
    let news = TopHeadlineModel(
      id: "1", name: "CNN", title: "NewsTest Judul yang agak panjang coba tambah lagi", author: "Author Test", description: "Ini Test Deskripsiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii lkajsldfjiasjdlfkjalsdifjlaskdfjlijlaksjflijasldkfjlasidjfllaisdjflaksjdfliajsdflaisjdflkajsdflijlasidfjlaskdfj", detailUrl: "", urlToImage: "https://a57.foxsports.com/statics.foxsports.com/www.foxsports.com/content/uploads/2023/04/1408/814/4.4.23_Writers-NFL-Mock-Draft_16x9-1.jpg?ve=1&tl=1", content: "", publishedAt: "2023-04-05T14:15:00Z", isSaved: false
    )
      return SavedNewsWidget(presenter: HomePresenter(), news: news, isSaved: news.isSaved)
  }
}
