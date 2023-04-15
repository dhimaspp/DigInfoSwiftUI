//
//  SavedNewsEntity.swift
//  DigInfo
//
//  Created by Dhimas P Pangestu on 11/04/23.
//

import Foundation
import RealmSwift

class SavedNewsEntity: Object {
  
    @objc dynamic var id: String = ""
    @objc dynamic var author: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var desc: String = ""
    @objc dynamic var url: String = ""
    @objc dynamic var urlToImage: String = ""
    @objc dynamic var publishedAt: String = ""
    @objc dynamic var content: String = ""
    @objc dynamic var name: String = ""
 
  override static func primaryKey() -> String? {
    return "title"
  }
}
