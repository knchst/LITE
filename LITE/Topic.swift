//
//  Topic.swift
//  LITE
//
//  Created by Kenichi Saito on 4/23/17.
//  Copyright © 2017 Kenichi Saito. All rights reserved.
//

import RealmSwift
import ObjectMapper

class Topic: Object, Mappable {
    dynamic var id = Int()
    dynamic var title = String()
    dynamic var captionImageUrl = String()
    dynamic var meta: Meta?
    
    override static func primaryKey() -> String {
        return "id"
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        captionImageUrl <- map["captionImageUrl"]
        meta <- map["meta"]
    }
}

class Meta: Object, Mappable {
    dynamic var destination = String()
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        destination <- map["destination"]
    }
}
