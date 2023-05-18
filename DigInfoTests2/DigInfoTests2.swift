//
//  DigInfoTests2.swift
//  DigInfoTests2
//
//  Created by Dhimas P Pangestu on 02/05/23.
//

import XCTest
import XCTest
import RxSwift
@testable import DigInfo
import RxTest

final class DigInfoTests2: XCTestCase {
        var disposeBag = DisposeBag()
        var homeInteractor: HomeInteractor!
        var newsRepositoryMock: NewsRepositoryMock!
        var scheduler: TestScheduler!

       override func setUp() {
           super.setUp()
           newsRepositoryMock = NewsRepositoryMock()
           scheduler = TestScheduler(initialClock: 0)
           homeInteractor = HomeInteractor(repository: newsRepositoryMock)
       }

       override func tearDown() {
           newsRepositoryMock = nil
           homeInteractor = nil
           disposeBag = DisposeBag()
           scheduler = nil
           newsRepositoryMock = nil
           homeInteractor = nil
           super.tearDown()
       }

    func testGetTopHeadlineCountry() {
        let expectation = XCTestExpectation(description: "Get top headline country")
        let expectedValue = [
            TopHeadlineModel(id: "1", name: "USA Today", title: "Test Title 1", author: "John Doe", description: "Test Description 1", detailUrl: "https://test.com/1", urlToImage: "https://test.com/1.jpg", content: "Test Content 1", publishedAt: "2022-01-01T00:00:00Z", isSaved: false),
            TopHeadlineModel(id: "2", name: "USA Today", title: "Test Title 2", author: "Jane Doe", description: "Test Description 2", detailUrl: "https://test.com/2", urlToImage: "https://test.com/2.jpg", content: "Test Content 2", publishedAt: "2022-01-02T00:00:00Z", isSaved: false),
            TopHeadlineModel(id: "3", name: "USA Today", title: "Test Title 3", author: "Bob Smith", description: "Test Description 3", detailUrl: "https://test.com/3", urlToImage: "https://test.com/3.jpg", content: "Test Content 3", publishedAt: "2022-01-03T00:00:00Z", isSaved: false),
        ]
        let response = scheduler.createObserver([TopHeadlineModel].self)
        let errorResponse = scheduler.createObserver(Error.self)
        
        scheduler.scheduleAt(0) {
            self.homeInteractor.getTopHeadlineCountry()
                .subscribe(onNext: { value in
                    response.onNext(value)
                    expectation.fulfill()
                }, onError: { error in
                    errorResponse.onNext(error)
                    expectation.fulfill()
                })
                .disposed(by: self.disposeBag)
        }
        
        scheduler.start()
        scheduler.scheduleAt(10) {
            XCTAssertEqual(response.events.count, 2)
            
            let firstEvent = response.events[0]
            XCTAssertEqual(firstEvent.time, 0)
            XCTAssertEqual(firstEvent.value.element?.count, expectedValue.count)
            XCTAssertEqual(firstEvent.value.element?[0], expectedValue[0])
            XCTAssertEqual(firstEvent.value.element?[1], expectedValue[1])
            XCTAssertEqual(firstEvent.value.element?[2], expectedValue[2])
            
            let secondEvent = response.events[1]
            XCTAssertEqual(secondEvent.time, 0)
            XCTAssertNil(secondEvent.value.element)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
   }

   class NewsRepositoryMock: NewsRepositoryProtocol {
       
       var topHeadlinesCountryData: [TopHeadlineModel]?
       var savedNewsData: [TopHeadlineModel]?
       
       func getTopHeadlinessCountry() -> Observable<[TopHeadlineModel]> {
           guard let data = topHeadlinesCountryData else {
               return Observable.error(MockError.noData)
           }
           return Observable.just(data)
       }
       
       func getSavedNews() -> Observable<[TopHeadlineModel]> {
           guard let data = savedNewsData else {
               return Observable.error(MockError.noData)
           }
           return Observable.just(data)
       }
       
       func addSavedNews(domain: TopHeadlineModel) -> Observable<Bool> {
           guard let data = savedNewsData else {
               savedNewsData = [domain]
               return Observable.just(true)
           }
           if data.contains(where: { $0.title == domain.title }) {
               return Observable.error(MockError.alreadyExists)
           }
           savedNewsData?.append(domain)
           return Observable.just(true)
       }
       
       func deleteSavedNews(domain: TopHeadlineModel) -> Observable<Bool> {
           guard let data = savedNewsData else {
               return Observable.just(false)
           }
           if let index = data.firstIndex(where: { $0.title == domain.title }) {
               savedNewsData?.remove(at: index)
               return Observable.just(true)
           } else {
               return Observable.just(false)
           }
       }
   }

   enum MockError: Error {
       case noData
       case alreadyExists
   }
