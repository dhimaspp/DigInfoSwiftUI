//
//  DetailUseCase.swift
//  DigInfo
//
//  Created by Dhimas P Pangestu on 08/04/23.
//

import Foundation
import RxSwift

protocol DetailUseCase {

}

class DetailInteractor: DetailUseCase {

  private let repository: NewsRepositoryProtocol

  required init(
    repository: NewsRepositoryProtocol
  ) {
    self.repository = repository
  }
}
