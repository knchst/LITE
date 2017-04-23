//
//  Article.swift
//  LITE
//
//  Created by Kenichi Saito on 4/23/17.
//  Copyright © 2017 Kenichi Saito. All rights reserved.
//

import RealmSwift
import ObjectMapper

class Article: Object, Mappable {
    dynamic var id = Int()
    dynamic var userId = Int()
    dynamic var title = String()
    dynamic var captionImageUrl = String()
    dynamic var url = String()
    
    override static func primaryKey() -> String {
        return "id"
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        userId <- map["userId"]
        title <- map["title"]
        captionImageUrl <- map["captionImageUrl"]
        url <- map["url"]
    }
}
