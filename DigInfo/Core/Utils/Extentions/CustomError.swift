//
//  CustomError.swift
//  Diginfo
//
//  Created by Dhimas P Pangestu on 20/03/23.
//

import Foundation

enum URLError: LocalizedError {

  case invalidResponse
  case addressUnreachable(URL)

  var errorDescription: String? {
    switch self {
    case .invalidResponse: return "Maaaf, Server lagi error nih, Mohon coba lagi beberapa saat."
    case .addressUnreachable(let url): return "\(url.absoluteString) tidak tergapai."
    }
  }
}

enum DatabaseError: LocalizedError {

  case invalidInstance
  case requestFailed

  var errorDescription: String? {
    switch self {
    case .invalidInstance: return "Database can't instance."
    case .requestFailed: return "Your request failed."
    }
  }
}
