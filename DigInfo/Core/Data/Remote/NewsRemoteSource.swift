//
//  NewsRemoteSource.swift
//  Diginfo
//
//  Created by Dhimas P Pangestu on 20/03/23.
//

import Foundation
import RxSwift
import Alamofire

protocol NewsRemoteSourceProtocol: AnyObject {
    
    func getTopHeadlineCountry() -> Observable<[Article]>
    
}

final class NewsRemoteSource: NSObject {

  private override init() { }

  static let sharedInstance: NewsRemoteSource =  NewsRemoteSource()

}

extension NewsRemoteSource: NewsRemoteSourceProtocol {
    
    
    func getTopHeadlineCountry() -> Observable<[Article]> {
        return Observable<[Article]>.create{ observer in
            if let url = URL(string: Endpoints.Gets.topHeadlineCountry.url){
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                AF.request(url).validate().responseDecodable(of: NewsResponse.self){ response in
                    print("masuk get top headline remote source " + Endpoints.Gets.topHeadlineCountry.url)
                    switch response.result {
                    case.success(let value):
                        observer.onNext(value.articles)
                        print("sukses get top headline remote source " + (value.articles.first?.title)!)
                        observer.onCompleted()
                    case.failure(let error):
                        observer.onError(URLError.invalidResponse)
                        print("gagal get top headline remote source " + error.localizedDescription)
                    }
                    
                }
            }
            return Disposables.create()
        }
    }
}
