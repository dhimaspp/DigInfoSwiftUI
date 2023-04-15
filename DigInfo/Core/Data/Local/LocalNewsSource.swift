//
//  LocalNewsRepository.swift
//  DigInfo
//
//  Created by Dhimas P Pangestu on 07/04/23.
//

import Foundation
import RealmSwift
import RxSwift
 
protocol LocaleDataSourceProtocol: AnyObject {
  //RxSwift
    func getNews() -> Observable<[ArticleEntity]>
    func addNews(from categories: [ArticleEntity]) -> Observable<Bool>
    func getSavedNews() -> Observable<[SavedNewsEntity]>
    func addSaveNews(from categories: SavedNewsEntity) -> Observable<Bool>
    func deleteSavedNews(from categories: SavedNewsEntity) -> Observable<Bool>
  
  //Combine
//  func getCategories() -> AnyPublisher<[CategoryEntity], Error>
//  func addCategories(from categories: [CategoryEntity]) -> AnyPublisher<Bool, Error>
}
 
final class LocaleNewsSource: NSObject {
 
  private let realm: Realm?
  private init(realm: Realm?) {
    self.realm = realm
  }
  static let sharedInstance: (Realm?) -> LocaleNewsSource = {
    realmDatabase in return LocaleNewsSource(realm: realmDatabase)
  }
}

extension LocaleNewsSource: LocaleDataSourceProtocol {
  //RxSwift
    func getNews() -> Observable<[ArticleEntity]> {
        return Observable<[ArticleEntity]>.create{ observer in
            if let realm = self.realm {
                let articles: Results<ArticleEntity> = {
                    realm.objects(ArticleEntity.self)
                        .sorted(byKeyPath: "url", ascending: true)
                }()
                observer.onNext(articles.toArray(ofType: ArticleEntity.self))
                observer.onCompleted()
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }

  func addNews(
    from articles: [ArticleEntity]) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            if let realm = self.realm {
                do {
                    try realm.write {
                        for article in articles {
                            realm.add(article, update: .all)
                        }
                        observer.onNext(true)
                        observer.onCompleted()
                    }
                } catch {
                    observer.onError(DatabaseError.requestFailed)
                }
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }
    
    func getSavedNews() -> Observable<[SavedNewsEntity]> {
        return Observable<[SavedNewsEntity]>.create{ observer in
            if let realm = self.realm {
                let articles: Results<SavedNewsEntity> = {
                    realm.objects(SavedNewsEntity.self)
                        .sorted(byKeyPath: "url", ascending: true)
                }()
                observer.onNext(articles.toArray(ofType: SavedNewsEntity.self))
                observer.onCompleted()
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }
    
    func addSaveNews(
      from article: SavedNewsEntity) -> Observable<Bool> {
          return Observable<Bool>.create { observer in
              if let realm = self.realm {
                  do {
                      try realm.write {
                          realm.add(article, update: .all)
                          observer.onNext(true)
                          observer.onCompleted()
                      }
                  } catch {
                      observer.onError(DatabaseError.requestFailed)
                  }
              } else {
                  observer.onError(DatabaseError.invalidInstance)
              }
              return Disposables.create()
          }
      }
    
    func deleteSavedNews(from article: SavedNewsEntity) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            if let realm = self.realm {
                if let objectToDelete = realm.objects(SavedNewsEntity.self).filter("title = %@", article.title).first {
                    do {
                        try realm.write {
                            realm.delete(objectToDelete)
                            observer.onNext(true)
                            observer.onCompleted()
                        }
                    } catch {
                        observer.onError(DatabaseError.requestFailed)
                    }
                } else {
                    observer.onNext(false)
                    observer.onCompleted()
                }
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }}
 
extension Results {
  func toArray<T>(ofType: T.Type) -> [T] {
    var array = [T]()
    for index in 0 ..< count {
      if let result = self[index] as? T {
        array.append(result)
      }
    }
    return array
  }
}
